class CreateGladiatorTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :gladiator_types do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :base_attack_points, null: false
      t.integer :base_health_points, null: false
      t.integer :dexterity, null: false
      t.integer :constitution, null: false

      t.timestamps
    end
  end
end
