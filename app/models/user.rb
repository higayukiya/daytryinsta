class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy

  has_many :timelines, dependent: :destroy

  has_many :likes, dependent: :destroy

  validates :username, presence: true, length: { maximum: 50 }
  validates :username, uniqueness: true

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
