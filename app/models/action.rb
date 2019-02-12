# frozen_string_literal: true

class Action < ApplicationRecord
  #
  # Validations
  #

  #
  # Associations
  #
  belongs_to :fight,
             class_name: 'Fight',
             foreign_key: 'fight_id',
             inverse_of: :actions

  belongs_to :character,
             class_name: 'Character',
             foreign_key: 'current_fighter_id',
             optional: true

  #
  # Through Associations
  #

  #
  # Callbacks
  #

  #
  # Scopes
  #
  scope :opponent, lambda { |character|
    where(
      'current_fighter_id IS NOT NULL AND current_fighter_id <> ?',
      character.id
    )
  }

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
# Table name: actions
#
#  id                  :bigint(8)        not null, primary key
#  damage              :integer          default(0)
#  fighter_left_score  :integer          default(0)
#  fighter_right_score :integer          default(0)
#  left_hp             :integer          default(0)
#  right_hp            :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  current_fighter_id  :bigint(8)
#  fight_id            :bigint(8)
#
# Indexes
#
#  index_actions_on_current_fighter_id  (current_fighter_id)
#  index_actions_on_fight_id            (fight_id)
#
