# frozen_string_literal: true

class GladiatorType < ApplicationRecord
  #
  # Active Storage
  #
  has_one_attached :avatar

  #
  # Validations
  #
  validates :name,
            :description,
            :base_health_points,
            :base_attack_points,
            presence: true

  #
  # Associations
  #
  has_many :characters,
           class_name: 'Character',
           foreign_key: 'gladiator_type_id',
           dependent: :destroy,
           inverse_of: :gladiator_type

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
# Table name: gladiator_types
#
#  id                 :bigint(8)        not null, primary key
#  base_attack_points :integer          not null
#  base_health_points :integer          not null
#  constitution       :integer          not null
#  description        :text             not null
#  dexterity          :integer          not null
#  name               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
