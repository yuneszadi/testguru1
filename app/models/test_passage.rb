class TestPassage < ApplicationRecord
  SUCCESS_MINIMAL = 85

  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_question

  before_save :before_save_set_result

  scope :successfull, -> { where('result > :success_minimal', success_minimal: SUCCESS_MINIMAL) }

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def completed?
    current_question.nil?
  end

  def empty_answer?(answer_ids)
    answer_ids.nil?
  end

  def result_to_percent
    correct_questions.to_f / test.questions.count * 100
  end

  def success?
    result_to_percent >= SUCCESS_MINIMAL
  end

  def question_number
    test.questions.where('id < ?', current_question.id).count + 1
  end

  private

  def before_save_set_result
    self.result = result_to_percent
  end

  def before_validation_set_question
    self.current_question = next_question
  end

  def correct_answer?(answer_ids)
    correct_answers.ids.sort == answer_ids.map(&:to_i).sort
  end

  def correct_answers
    current_question.answers.correct
  end

  def next_question
    return test.questions.first if current_question.nil?
    test.questions.order(:id).where('id > ?', current_question.id).first
  end
end
