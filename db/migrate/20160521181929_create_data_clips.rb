class CreateDataClips < ActiveRecord::Migration
  def change
    create_table :data_clips do |t|
      t.text :data
      t.boolean :starred
      t.boolean :is_url
      t.references :user, index: true, foreign_key: true
      t.references :channel, index: true, foreign_key: true
      t.json :slack_response

      t.timestamps null: false
    end
  end
end
