class CreateFights < ActiveRecord::Migration[5.2]
  def change
    create_table :fights do |t|
      t.belongs_to :fighter_left, index: true
      t.belongs_to :fighter_right, index: true

      t.belongs_to :winning_character, index: true
      t.belongs_to :losing_character, index: true

      t.timestamps
    end
  end
end
