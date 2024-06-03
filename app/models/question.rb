class Question < ApplicationRecord
  belongs_to :quiz
  validates :correct_answer, inclusion: { in: 1..3 }
  has_one_attached :image
end
