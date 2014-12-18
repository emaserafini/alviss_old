class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :data_kind

      t.timestamps null: false
    end
  end
end
