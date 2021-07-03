class CommentMailer < ApplicationMailer
    def new_mention(mention_user_ids)
        @users = User.where(id: mention_user_ids)
        @user_email = @users.pluck(:email)

        mail to: @users_email, subject: '【お知らせ】メンションされました'
    end
end