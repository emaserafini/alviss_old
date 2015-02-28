class CreateThermostats < ActiveRecord::Migration
  def change
    create_table :thermostats do |t|
      t.string :name
      t.integer :active_mode, default: 0

      t.timestamps null: false
    end
  end
end
