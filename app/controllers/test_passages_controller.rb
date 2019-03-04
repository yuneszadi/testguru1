class TestPassagesController < ApplicationController
  before_action :find_test_passage, only: %i[show result update]
  before_action :check_time, only: :update

  def show; end

  def result; end

  def update
    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      current_user.badges << BadgeService.new(@test_passage).build
      TestsMailer.completed_test(@test_passage).deliver_now
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  def gist
    @result = GistQuestionService.new.create_gist(@test_passage.current_question)

    if @result.success?
      @gist = Gist.create!(gist_params)
      flash[:notice] = t('.success', link: @result.html_url)
    else
      flash[:alert] = t('.failure')
    end
    redirect_to @test_passage
  end

  private

  def check_time
    @test_passage.stop if check_remaining_time
  end

  def check_remaining_time
    @test_passage.test.with_timer? && @test_passage.end_time?
  end

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end

  def gist_params
    {
      question: @test_passage.current_question,
      gist_url: @result.html_url,
      user: current_user
    }
  end
end
