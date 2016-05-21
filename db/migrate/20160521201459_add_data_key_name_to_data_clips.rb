class AddDataKeyNameToDataClips < ActiveRecord::Migration
  def change
    add_column :data_clips, :data_clip_name, :string
  end
end
