class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :timeline

    validates :content, presence: true, length: { 1..100 }
end
