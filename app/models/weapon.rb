# frozen_string_literal: true

class Weapon < ApplicationRecord
  #
  # Validations
  #
  validates :name,
            :damage,
            presence: true

  #
  # Associations
  #
  has_many :equipments,
           as: :usables,
           dependent: :destroy

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
