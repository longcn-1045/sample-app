class Micropost < ApplicationRecord
  MICROPOST_PARAMS = %i(content image).freeze

  belongs_to :user

  has_one_attached :image

  delegate :name, to: :user

  validates :user_id, presence: true
  validates :content, presence: true,
     length: {maximum: Settings.number.max_content}

  scope :order_created_at, ->{order created_at: :desc}
  scope :micropost_feed, ->user_ids{where user_id: user_ids}

  def display_image
    image.variant resize_to_limit: Settings.number.resize_to_limit
  end
end
