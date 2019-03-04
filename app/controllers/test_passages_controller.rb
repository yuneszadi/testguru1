class TestPassagesController < ApplicationController

  before_action :find_test_passage, only: %i[show result update]

  def show; end

  def result; end

  def update
    if @test_passage.empty_answer?(params[:answer_ids])
      return render :show, alert: "You did't select any answers."
    end

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
