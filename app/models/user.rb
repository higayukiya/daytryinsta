class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy

  has_many :timelines, dependent: :destroy

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy

  validates :username, presence: true, length: { maximum: 50 }
  validates :username, uniqueness: true

  #フォロー機能
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :following_relationships
  has_many :follower_relationships, foreign_key: "following_id", class_name: "Relationship", dependent: :destroy
  has_many :followers, through: :follower_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
  following_relationships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
  following_relationships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
  following_relationships.find_by(following_id: user.id).destroy
  end

  # def user_name
  #   if profile&.nickname&.present?
  #     profile.nickname
  #   else
  #     username
  #   end
  # end

  def has_liked?(timelines)
    likes.exists?(timeline_id: timelines.id)
  end

  def prepare_profile
    profile || build_profile
  end

  def avatar_img
    if profile&.avatar&.attached?
      profile.avatar
    else
      'default-avatar.png'
    end
  end
end
