# frozen_string_literal: true

class Weapon < ApplicationRecord
  #
  # Validations
  #

  #
  # Associations
  #
  has_many :equipments,
           class_name: 'Equipment',
           foreign_key: 'equipment_id',
           dependent: :destroy,
           inverse_of: :weapon

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
# Table name: weapons
#
#  id         :bigint(8)        not null, primary key
#  damage     :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
