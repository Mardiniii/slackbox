class SetDefaultValueToDataClipsTable < ActiveRecord::Migration
  def change
    change_column :data_clips, :starred, :boolean, :default => false
    change_column :data_clips, :is_url, :boolean, :default => false
  end
end
