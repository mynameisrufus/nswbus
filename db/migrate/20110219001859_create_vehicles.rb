class CreateVehicles < ActiveRecord::Migration
  def self.up
    create_table :vehicles do |t|
      t.integer :vehicleid
      t.float :latitude
      t.float :longitude
      t.string :tripstatus
      t.integer :routedirection
      t.integer :routevariant
      t.string :routename
      t.string :servicedescription
      t.string :organisation

      t.timestamps
    end
  end

  def self.down
    drop_table :vehicles
  end
end
