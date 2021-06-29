class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  def comment_content(comment)
    @user = comment.user
    @article = comment.article
    mail to: @user.email, subjuct: '[お知らせ]　あなたについてコメントしました'
  end
end
