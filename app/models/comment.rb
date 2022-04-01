class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :micropost
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  default_scope -> { order(created_at: :desc)}
  validates :body, presence: true
  validates :user_id, presence: true
  validates :micropost_id, presence: true
end
