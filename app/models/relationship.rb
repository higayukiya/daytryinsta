class Relationship < ApplicationRecord
    #自分をフォローしているユーザー,Userにすることで存在しないfollowrクラス、followingクラス参照しないようにする
    belongs_to :follower, class_name: "User"
    #自分がフォローしているユーザー
    belongs_to :following, class_name: "User"
    #バリデーション
    validates :follower_id, presence: true
    validates :following_id, presence: true
end
