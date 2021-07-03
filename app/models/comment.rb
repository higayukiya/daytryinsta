class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :timeline

    validates :content, presence: true

    after_create :send_email

    def has_username?
        username = User.pluck(:username)
        # 全てのユーザーの中からusernameカラムの値のみを配列で取得
        username.any? { |username| content.include?("@#{username}") }
        # コメント内に"@"+"username"が含まれているかどうかを検索
    end
    
    after_create :send_email, if: :has_username?
    
    private
    
    def send_email
        mention = content.scan(/@\w+/)
        # content内から"@"+"username"を配列で抜き出す
        mention_username = mention.join(',').scan(/\w+/)
        # mentionを配列から文字列に変換し、@以外を抜き出す
        mention_user = User.where(username: mention_username)
        # ユーザーの中からusrenameキーを指定し、mentionus_rnameに該当するユーザーを探す
        mention_user_ids = mention_user.map(&:id)
        # そのままユーザーを渡せないのでmapを使ってidに変換
        CommentMailer.new_mention(mention_user_ids).deliver_later
    end
end

#今後のために、KosukeKatayamaさんのコードを参考にしました。