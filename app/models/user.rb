class User < ApplicationRecord
  def find_by_level(level)
    Test.joins('JOIN user_tests ON user_tests.test_id = tests.id').where(
      level: level,
      user_tests: { user_id: id }
    )
  end
end
