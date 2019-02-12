class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.integer :fighter_left_score, default: 0
      t.integer :fighter_right_score, default: 0
      t.integer :damage, default: 0
      t.integer :left_hp, default: 0
      t.integer :right_hp, default: 0

      t.belongs_to :current_fighter, index: true
      t.belongs_to :fight, index: true

      t.timestamps
    end
  end
end
