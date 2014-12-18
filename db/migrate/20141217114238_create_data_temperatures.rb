class CreateDataTemperatures < ActiveRecord::Migration
  def change
    create_table :data_temperatures do |t|
      t.belongs_to :feed, index: true
      t.decimal :value, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
