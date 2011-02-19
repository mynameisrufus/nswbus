class CreateStops < ActiveRecord::Migration
  def self.up
    create_table :stops do |t|
      t.integer :tsn
      t.string :organisation
      t.string :destination
      t.integer :vehicleid
      t.boolean :realtime
      t.timestamp :arrivaltime
      t.string :routename

      t.timestamps
    end
  end

  def self.down
    drop_table :stops
  end
end
