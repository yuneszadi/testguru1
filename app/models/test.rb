class Test < ApplicationRecord
  has_many :test_passages
  has_many :users, through: :test_passages  belongs_to :category
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
  validates :timer, presence: true

  def self.find_by_category(category)
    joins('JOIN categories ON categories.id = tests.category_id')
      .where(categories: { title: category })
      .order(title: :desc)
      .pluck(:title)
  end

  def with_timer?
    timer.positive?
  end
end
