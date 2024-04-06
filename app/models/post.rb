class Post < ApplicationRecord
    enum post_type: { job: 0, event: 1, news: 2 }
    TAGS = ['job', 'event', 'news', 'AI', 'students']
    validates :title, presence: true
    validates :location, presence: true
    validates :date, presence: true
    validates :organiser, presence: true
    # validates :deadline, presence: true
    validates :description, presence: true
    validates :url, presence: true
    validates :post_type, presence: true
    # validates :emailed, presence: true
    validates :tags, presence: true
    validates :recurring, presence: true
end