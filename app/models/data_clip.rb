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

  scope :filter_by_name_or_data, lambda { |keyword|
    where("lower(data_clips.name) LIKE ? OR lower(data_clips.data) LIKE ?", "%#{keyword.downcase}%", "%#{keyword.downcase}%" )
  }

  scope :starred, lambda { where(starred: true) }

  def self.search(params = {})
    params = parse_data(params[:q]) if params[:q]
    if params && params[:tags]
      data_clips = params[:tags].count > 0 ? all.joins(:tags).where(:"tags.name" => params[:tags]) : all
      data_clips = data_clips.filter_by_name_or_data(params[:name]) if params[:name]
      data_clips
    else
      all
    end
  end

  def self.parse_data(params = {})
    value = params.gsub(/#\w+/,'')
    tags = params.scan(/#\w+/).uniq
    { name: value, tags: tags }
  end

  def tag_list
    tags.pluck(:name).uniq
  end

  def as_json(opts={})
    super(opts).merge(tags: tag_list)
  end
end
