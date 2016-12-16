class Word < ApplicationRecord

  belongs_to :category, optional: true
  has_many :results, dependent: :destroy
  has_many :meanings, dependent: :destroy, inverse_of: :word
  has_many :lessons, through: :results

  accepts_nested_attributes_for :meanings

  validates :content, presence: true, length: {maximum: Settings.user.word.maximum}
  accepts_nested_attributes_for :results
end
