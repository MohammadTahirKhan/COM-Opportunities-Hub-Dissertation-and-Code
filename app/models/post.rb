# == Schema Information
#
# Table name: posts
#
#  id                      :bigint           not null, primary key
#  custom_recurring_info   :string
#  deadline                :date
#  description             :string
#  email                   :string
#  emailed                 :boolean
#  end_date                :date
#  end_time                :time
#  location                :string
#  organiser               :string
#  recurring               :boolean
#  recurring_interval_num  :integer
#  recurring_interval_unit :string
#  start_date              :date
#  start_time              :time
#  tags                    :string           default([]), is an Array
#  title                   :string
#  url                     :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#
class Post < ApplicationRecord
    # POST_ATTRIBUTES_PARAMS = %i[title location date organiser deadline description url post_type emailed tags:[] recurring].freeze
    # enum post_type: { job: 0, event: 1, news: 2 }
    # TAGS = ['job', 'event', 'news', 'AI', 'students']
    validates :email, presence: true
    validates :title, presence: true
    validates :location, presence: true
    validates :start_date, presence: true
    validates :organiser, presence: true
    # validates :deadline, presence: true
    validates :description, presence: true
    validates :url, presence: true
    # validates :post_type, presence: true
    # validates :emailed, presence: true
    validates :tags, presence: true
    validates :recurring, presence: true
end
