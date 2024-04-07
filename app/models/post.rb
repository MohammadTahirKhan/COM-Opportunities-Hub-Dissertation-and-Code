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
#  published               :boolean          default(FALSE)
#  published_at            :datetime
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
    # validates :start_time, presence: true
    validates :end_date, presence: true
    # validates :end_time, presence: true
    validates :organiser, presence: true
    # validates :deadline, presence: true
    validates :description, presence: true
    validates :url, presence: true
    # validates :post_type, presence: true
    # validates :emailed, presence: true
    validates :tags, presence: true
    validate :at_least_one_tag

    validate :start_date_and_end_date_cannot_be_in_the_past
    validate :end_date_cannot_be_before_start_date

    
    validate :recurring_interval_num_cannot_be_negative
    validate :recurring_interval_unit_cannot_be_blank_if_recurring_num_present
    validate :custom_recurring_info_cannot_be_blank_if_recurring
    validates :recurring, inclusion: { in: [true, false] }

    def at_least_one_tag
        errors.add(:tags, 'must have at least one tag') if tags.length<2
    end
    
    def recurring_interval_num_cannot_be_negative
        if recurring_interval_num.present? && recurring_interval_num <= 0
            errors.add(:recurring_interval_num, "can't be zero or negative")
        end
    end

    def recurring_interval_unit_cannot_be_blank_if_recurring_num_present
        if recurring_interval_num.present? && recurring_interval_unit.blank?
            errors.add(:recurring_interval_unit, "can't be blank if recurring interval number is present")
        end
    end

    def custom_recurring_info_cannot_be_blank_if_recurring
        if recurring && custom_recurring_info.blank?
            errors.add(:custom_recurring_info, "can't be blank if recurring")
        end
    end

    def start_date_and_end_date_cannot_be_in_the_past
        if start_date < Date.today
            errors.add(:start_date, "can't be in the past")
        end
        if end_date < Date.today
            errors.add(:end_date, "can't be in the past")
        end

    end

    def end_date_cannot_be_before_start_date
        if start_date.present? && end_date.present? && start_date > end_date
            errors.add(:end_date, "can't be before start date")
        end
    end
    


end
