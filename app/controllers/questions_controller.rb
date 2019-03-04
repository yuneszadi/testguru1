class QuestionsController < ApplicationController
  before_action :find_question, only: %i[show destroy]
  before_action :find_test, only: %i[create index]

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_question_not_found
  def index
    render json: { questions: @test.questions }
  end

  def show; end

  def new; end

  def create
    @test.questions.create(new_question_parameters)
    render html: '<h3><center>Question create</center></h3>'.html_safe
  end

  def destroy
    @question.destroy
    redirect_to test_questions_path
  end

  private

  def new_question_parameters
    params.require(:question).permit(:body)
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def rescue_with_question_not_found
    render plain: 'Question was not found'
  end
end
