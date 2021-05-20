class Timeline < ApplicationRecord
    belongs_to :user
    has_many_attached :album
    has_many :likes, dependent: :destroy

    validates :title, presence: true, length: { maximum: 200 }

    def created_add
        Time.zone.now.yday
    end
end
