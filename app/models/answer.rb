class Answer < ApplicationRecord
  belongs_to :question
  scope :correct, -> { where(correct: true) }

  validates :body, presence: true
  validate :validate_answer_count, on: :create

  private

  def validate_answer_count
    errors.add(:question_id) if question.answers.count > 3
  end
end
