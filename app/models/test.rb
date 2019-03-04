class Test < ApplicationRecord
  has_many :tests
  belongs_to :category
  has_many :questions
  belongs_to :author, class_name: 'User'

  scope :easy, -> { where(level: 0..1) }
  scope :normal, -> { where(level: 2..4) }
  scope :hard, -> { where(level: 5..Float::INFINITY) }

  validates :title, presence: true
  validates :level, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0
  }
  validates :title, uniqueness: { scope: :level }

  def self.find_by_category(category)
    joins('JOIN categories ON categories.id = tests.category_id')
      .where(categories: { title: category })
      .order(title: :desc)
      .pluck(:title)
  end
end
