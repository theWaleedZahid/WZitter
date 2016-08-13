class Post < ActiveRecord::Base
  acts_as_votable
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 } # tweets are capped at 140 chars.
  default_scope -> { order(created_at: :desc) } # newest tweets / posts first
end
