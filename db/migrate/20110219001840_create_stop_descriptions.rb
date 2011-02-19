class CreateStopDescriptions < ActiveRecord::Migration
  def self.up
    create_table :stop_descriptions do |t|
      t.integer :tsn
      t.float :latitude
      t.float :longitude
      t.string :tsndescription

      t.timestamps
    end
  end

  def self.down
    drop_table :stop_descriptions
  end
end
