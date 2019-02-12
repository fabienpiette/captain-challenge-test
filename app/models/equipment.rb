# frozen_string_literal: true

class Equipment < ApplicationRecord
  #
  # Validations
  #

  #
  # Associations
  #
  belongs_to :weapon,
             class_name: 'Weapon',
             foreign_key: 'weapon_id',
             inverse_of: :equipments

  belongs_to :character,
             class_name: 'Character',
             foreign_key: 'character_id',
             inverse_of: :equipments

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
# Table name: equipment
#
#  id           :bigint(8)        not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :bigint(8)
#  weapon_id    :bigint(8)
#
# Indexes
#
#  index_equipment_on_character_id  (character_id)
#  index_equipment_on_weapon_id     (weapon_id)
#
