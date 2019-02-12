class CreateEquipment < ActiveRecord::Migration[5.2]
  def change
    create_table :equipment do |t|
      t.belongs_to :weapon, index: true
      t.belongs_to :character, index: true

      t.timestamps
    end
  end
end
