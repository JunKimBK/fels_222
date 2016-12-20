class Relationship < ApplicationRecord
  belongs_to :followed, class_name: User.name
  belongs_to :follower, class_name: User.name
  validate :follower_id
  validate :followed_id
end
