class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :avatar_comment_img
  belongs_to :user

  has_many :comments do
    object.comments.with_attached_images
  end


  def avatar_comment_img
    Rails.application.routes.url_helpers.rails_blob_path(object.avatar, only_path: true) if object.avatar.attached?
  end
end
