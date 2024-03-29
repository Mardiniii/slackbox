# == Schema Information
#
# Table name: teams
#
#  id         :integer          not null, primary key
#  name       :string
#  slack_id   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  domain     :string
#

class Team < ActiveRecord::Base
  has_many :channels
  has_many :users
  has_many :tags
  has_many :data_clips
end
