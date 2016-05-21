# == Schema Information
#
# Table name: channels
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  name       :string
#  slack_id   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Channel < ActiveRecord::Base
  belongs_to :team
end
