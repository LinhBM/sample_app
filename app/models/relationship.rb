class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name
  belongs_to :followed, class_name: User.name
  validates :followed, presence: true
  validates :follower, presence: true
end
