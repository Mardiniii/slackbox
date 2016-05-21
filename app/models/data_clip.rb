# == Schema Information
#
# Table name: data_clips
#
#  id             :integer          not null, primary key
#  data           :text
#  starred        :boolean          default(FALSE)
#  is_url         :boolean          default(FALSE)
#  user_id        :integer
#  channel_id     :integer
#  slack_response :json
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class DataClip < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  has_and_belongs_to_many :tags
end
