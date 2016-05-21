# == Schema Information
#
# Table name: data_clips
#
#  id             :integer          not null, primary key
#  data           :text
#  starred        :boolean          default(FALSE)
#  has_urls       :boolean          default(FALSE)
#  user_id        :integer
#  channel_id     :integer
#  slack_response :json
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string
#  team_id        :integer
#

class DataClip < ActiveRecord::Base
  belongs_to :user
  belongs_to :channel
  belongs_to :team
  has_and_belongs_to_many :tags

  accepts_nested_attributes_for :tags
end
