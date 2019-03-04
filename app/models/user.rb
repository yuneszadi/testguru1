class User < ApplicationRecord
  has_many :test_passages
  has_many :tests, through: :test_passages
  has_many :author_tests, class_name: 'Test', foreign_key: :author_id

  validates :email, uniqueness: true

  has_secure_password

  def test_passage(test)
    test_passages.order(created_at: :desc).find_by(test: test)
  end
end
