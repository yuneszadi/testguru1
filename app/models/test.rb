class Test < ApplicationRecord
  has_many :tests
  belongs_to :category
  has_many :questions
  belongs_to :author, class_name: 'User'

  def self.find_by_category(category)
    joins('JOIN categories ON categories.id = tests.category_id')
      .where(categories: { title: category })
      .order(title: :desc)
      .pluck(:title)
  end
end
