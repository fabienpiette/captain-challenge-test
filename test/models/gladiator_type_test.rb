# frozen_string_literal: true

require 'test_helper'

class GladiatorTypeTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @gladiator_type = gladiator_types(:one)
  end

  #
  # Validations
  #
  test 'valid gladiator_type' do
    assert @gladiator_type.valid?
  end

  test 'invalid without name' do
    gladiator_type      = gladiator_types(:one)
    gladiator_type.name = nil

    assert_not @gladiator_type.valid?, 'gladiator_type is valid without a name'
    assert_not_nil @gladiator_type.errors[:name], 'no validation error for name present'
  end

  test 'invalid without description' do
    gladiator_type = gladiator_types(:one)
    gladiator_type.description = nil

    assert_not @gladiator_type.valid?, 'gladiator_type is valid without a description'
    assert_not_nil @gladiator_type.errors[:description], 'no validation error for description present'
  end

  test 'invalid without base_health_points' do
    gladiator_type = gladiator_types(:one)
    gladiator_type.base_health_points = nil

    assert_not @gladiator_type.valid?, 'gladiator_type is valid without a base_health_points'
    assert_not_nil @gladiator_type.errors[:base_health_points], 'no validation error for base_health_points present'
  end

  test 'invalid without base_attack_points' do
    gladiator_type = gladiator_types(:one)
    gladiator_type.base_attack_points = nil

    assert_not @gladiator_type.valid?, 'gladiator_type is valid without a base_attack_points'
    assert_not_nil @gladiator_type.errors[:base_attack_points], 'no validation error for base_attack_points present'
  end

  #
  # Associations
  #

  #
  # Scopes
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
  #
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
