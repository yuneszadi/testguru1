class User < ApplicationRecord
  has_many :author_tests, class_name: 'Test', foreign_key: "author_id"

  def find_by_level(level)
    Test.joins('JOIN user_tests ON user_tests.test_id = tests.id').where(
      level: level,
      user_tests: { user_id: id }
    )
  end

  validates :username, presence: true
end
