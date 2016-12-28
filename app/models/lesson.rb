class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy

  after_save :start_lesson_activity

  private
  def start_lesson_activity
    Activity.create user_id: self.user_id, type_id: id,
      action_type: Activity.activity_types[:start_lesson]
  end
end
