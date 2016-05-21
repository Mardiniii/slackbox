class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :data_clips, :tags do |t|
      t.index [:data_clip_id, :tag_id]
      t.index [:tag_id, :data_clip_id]
    end
  end
end
