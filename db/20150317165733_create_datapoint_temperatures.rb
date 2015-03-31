class CreateDatapointTemperatures < ActiveRecord::Migration
  def change
    create_table :datapoint_temperatures do |t|
      t.references :stream, index: true
      t.decimal :value, precision: 5, scale: 2

      t.timestamps null: false
    end
    add_foreign_key :datapoint_temperatures, :streams
  end
end
