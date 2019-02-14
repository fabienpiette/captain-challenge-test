# frozen_string_literal: true

require 'test_helper'

class WeaponTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @weapon = weapons(:one)
  end

  #
  # Validations
  #
  test 'valid weapon' do
    assert @weapon.valid?
  end

  test 'invalid without name' do
    weapon      = weapons(:one)
    weapon.name = nil

    assert_not @weapon.valid?, 'weapon is valid without a name'
    assert_not_nil @weapon.errors[:name], 'no validation error for name present'
  end

  test 'invalid without damage' do
    weapon        = weapons(:one)
    weapon.damage = nil

    assert_not @weapon.valid?, 'weapon is valid without a damage'
    assert_not_nil @weapon.errors[:damage], 'no validation error for damage present'
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
