class Tweet < ApplicationRecord
  validates :body, presence: true, length: {:maximum => 280}

  default_scope { order(created_at: :desc) }
end
