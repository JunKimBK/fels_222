class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results
  before_create :make_random_words

  private
  def make_random_words
    word_ids = category.words.random
  end
end
