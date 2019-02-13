class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.integer :capacity_points, null: false, default: 0
      t.integer :xp_points, null: false, default: 0
      t.integer :level, null: false, default: 1
      t.integer :health_points, null: false, default: 20
      t.integer :attack_points, null: false, default: 1
      t.integer :dexterity, null: false, default: 1
      t.integer :constitution, null: false, default: 1

      t.belongs_to :user, index: true
      t.belongs_to :gladiator_type, index: true

      t.timestamps
    end
  end
end
