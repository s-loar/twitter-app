class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tweets
  has_many :comments

  validates :name, presence: true

  default_scope { order(name: :asc) }

  has_many :following_relationships,  class_name: "UserRelationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followers_relationships, class_name: "UserRelationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :following_relationships, source: :followed
  has_many :followers, through: :followers_relationships, source: :follower

  acts_as_liker

  def following?(other_user)
    following.include?(other_user)
  end

  def follow(other_user)
    following_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    following_relationships.find_by(followed_id: other_user.id).destroy
  end

  def twitter_feed
    following_ids = "SELECT followed_id FROM user_relationships WHERE  follower_id = ?"
    Tweet.where("user_id IN (#{following_ids}) OR user_id = ?", id, id)
  end

end
