class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :team, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
