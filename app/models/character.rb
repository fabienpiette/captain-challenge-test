# frozen_string_literal: true

class Character < ApplicationRecord
  #
  # Validations
  #
  validates :name,
            :health_points,
            :attack_points,
            presence: true

  #
  # Associations
  #
  belongs_to :owner,
             class_name: 'User',
             foreign_key: 'user_id',
             inverse_of: :characters,
             optional: true

  has_many :left_fights,
           class_name: 'Fight',
           foreign_key: 'fighter_left_id',
           dependent: :destroy,
           inverse_of: :fighter_left

  has_many :right_fights,
           class_name: 'Fight',
           foreign_key: 'fighter_right_id',
           dependent: :destroy,
           inverse_of: :fighter_right

  has_many :won_battles,
           class_name: 'Fight',
           foreign_key: 'winning_character_id',
           dependent: :destroy,
           inverse_of: :winning_character

  has_many :lost_battles,
           class_name: 'Fight',
           foreign_key: 'losing_character_id',
           dependent: :destroy,
           inverse_of: :losing_character

  has_many :equipments,
           class_name: 'Equipment',
           foreign_key: 'character_id',
           dependent: :destroy,
           inverse_of: :character

  #
  # Through Associations
  #

  #
  # Callbacks
  #

  #
  # Scopes
  #

  #
  # Supports
  #

  #
  # Public class methods
  #
  def fights
    Fight.where('fighter_left_id = ? OR fighter_right_id = ?', id, id)
  end

  def fight_strategy
    Strategies::Simple.new
  end

  def damage
    attack_points
  end

  #
  # Public instance methods
  #

  #
  # Protected instance methods
  #
  # protected
end

# == Schema Information
#
# Table name: characters
#
#  id            :bigint(8)        not null, primary key
#  attack_points :integer          default(1), not null
#  health_points :integer          default(20), not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :bigint(8)
#
# Indexes
#
#  index_characters_on_user_id  (user_id)
#
