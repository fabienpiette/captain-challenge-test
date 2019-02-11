class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name, null: false
      t.integer :health_points, null: false, default: 5
      t.integer :attack_points, null: false, default: 5

      t.timestamps
    end
  end
end
