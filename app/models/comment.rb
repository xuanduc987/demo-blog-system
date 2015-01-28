class Comment < ActiveRecord::Base
  default_scope -> { order(created_at: :asc) }

  belongs_to :user
  belongs_to :entry

  validates :user_id, presence: true
  validates :entry_id, presence: true
  validates :content, presence: true
end
