class Tweet < ApplicationRecord
  validates :body, presence: true, length: {:maximum => 140}

  default_scope { order(created_at: :desc) }

  belongs_to :user
  has_many :comments, dependent: :destroy

  acts_as_likeable

end
