# frozen_string_literal: true

class Character < ApplicationRecord
  #
  # Validations
  #
  validates :name,
            :health_points,
            :attack_points,
            presence: true

  validates :health_points,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 9
            },
            on: :create

  validates :attack_points,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 9
            },
            on: :create

  validate :points_balancing?, on: :create

  #
  # Associations
  #

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
  protected

  def points_balancing?
    return true if attack_points + health_points == 10

    errors[:base] << 'Your character is too unbalanced, you only have 10 '\
                     'points to divide between your health and your attack.'
  end
end

# == Schema Information
#
# Table name: characters
#
#  id            :bigint(8)        not null, primary key
#  attack_points :integer          default(5), not null
#  health_points :integer          default(5), not null
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
