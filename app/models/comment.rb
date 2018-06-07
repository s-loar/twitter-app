class Comment < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  validates :body, presence: true

  default_scope { order(created_at: :desc) }
end
