class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  has_many :comments

  validates :name, presence: true

  default_scope { order(name: :asc) }

  def following?(other_user)
    true
  end

  def follow(other_user)
  end

  def unfollow(other_user)
  end

end
