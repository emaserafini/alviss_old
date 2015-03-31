class CreateStreams < ActiveRecord::Migration
  def change
    create_table :streams do |t|
      t.string :name
      t.integer :kind

      t.timestamps null: false
    end
  end
end
