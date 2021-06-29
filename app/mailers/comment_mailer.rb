class CommentMailer < ApplicationMailer
    def new_comment(user)
        mail to: user.email, subject: '【お知らせ】新しいコメントがあります'
    end
end