# == Schema Information
#
# Table name: data_clips
#
#  id             :integer          not null, primary key
#  data           :text
#  starred        :boolean
#  is_url         :boolean
#  user_id        :integer
#  channel_id     :integer
#  slack_response :json
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class DataClipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
