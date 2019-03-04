class TestPassagesController < AuthController

  before_action :find_test_passage, only: %i[show result update]

  def show; end

  def result; end

  def update
    if @test_passage.empty_answer?(params[:answer_ids])
      return render :show, alert: "You did't select any answers."
    end

    @test_passage.accept!(params[:answer_ids])

    if @test_passage.completed?
      redirect_to result_test_passage_path(@test_passage)
    else
      render :show
    end
  end

  private

  def find_test_passage
    @test_passage = TestPassage.find(params[:id])
  end
end