class CreateThermostats < ActiveRecord::Migration
  def change
    create_table :thermostats do |t|
      t.integer :mode
      t.integer :status

      t.timestamps null: false
    end
  end
end
