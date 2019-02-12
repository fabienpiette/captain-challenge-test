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

  has_many :fighters,
           class_name: 'Fights::Fighter',
           foreign_key: 'character_id',
           dependent: :destroy,
           inverse_of: :character

  #
  # Through Associations
  #
  has_many :fights,
           class_name: 'Fight',
           through: :fighters

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
