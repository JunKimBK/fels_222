class User < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :activities, dependent: :destroy

  has_many :active_relationships,  class_name:  Relationship.name,
    foreign_key: :follower_id,
    dependent:   :destroy
  has_many :passive_relationships, class_name:  Relationship.name,
    foreign_key: :followed_id,
    dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :name, presence: true, length: {maximum:
    Settings.user.name.maximum_length}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:
    Settings.user.email.maximum_length},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum:
    Settings.user.password.minimum_length}

  def forget
    update_attribute :remember_digest, nil
  end
end
