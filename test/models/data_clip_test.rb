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
#  name           :string
#

require 'test_helper'

class DataClipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
