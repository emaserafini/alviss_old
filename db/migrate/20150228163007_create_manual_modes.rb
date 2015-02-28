class CreateManualModes < ActiveRecord::Migration
  def change
    create_table :manual_modes do |t|
      t.integer :thermostat_id
      t.decimal :setpoint_temperature, precision: 5, scale: 2
      t.decimal :deviation_temperature, precision: 5, scale: 2
      t.integer :minimum_run
      t.integer :feed_temperature_id
      t.integer :feed_status_id

      t.timestamps null: false
    end
    add_index(:manual_modes, :thermostat_id)
  end
end
