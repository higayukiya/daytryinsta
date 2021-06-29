class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :timeline

    validates :content, presence: true

    after_create :send_email

    private
    def send_email
        if self.content.include?("@")
        CommentMailer.comment_content(self).deliver_later
        end
    end
end
