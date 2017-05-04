class Micropost < ApplicationRecord
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user, presence: true
  validates :content, presence: true, length: {maximum: 140}
  validate :picture_size
  scope :desc, -> {order created_at: :desc}
  scope :feedmicropost, ->user{where user_id: user.following_ids << user.id}

  private
  def picture_size
    if picture.size > 5.megabytes
      errors.add :picture, I18n.t(".picture")
    end
  end
end
