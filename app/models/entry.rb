class Entry < ActiveRecord::Base
  default_scope -> { order(created_at: :desc) }

  belongs_to :user

  has_many :comments, dependent: :destroy

  validates :user_id, presence: true
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 255 }
end
