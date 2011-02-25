class CreateStopDescriptions < ActiveRecord::Migration
  def self.up
    create_table :stop_descriptions do |t|
      t.integer :tsn
      t.float :latitude
      t.float :longitude
      t.string :tsndescription

      t.timestamps
    end
    
    add_index :stop_descriptions, :tsn
    add_index :stop_descriptions, :latitude
    add_index :stop_descriptions, :longitude
    add_index :stop_descriptions, :tsndescription
  end

  def self.down
    drop_table :stop_descriptions
  end
end
