# frozen_string_literal: true

require 'test_helper'

class EquipmentTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @equipment = equipment(:one)
  end

  #
  # Validations
  #
  test 'valid equipment' do
    assert @equipment.valid?
  end

  test 'invalid without character' do
    equipment = equipment(:one)
    equipment.character = nil

    assert_not @equipment.valid?, 'equipment is valid without a character'
    assert_not_nil @equipment.errors[:character], 'no validation error for character present'
  end

  test 'invalid without usable' do
    equipment = equipment(:one)
    equipment.usable = nil

    assert_not @equipment.valid?, 'equipment is valid without a usable'
    assert_not_nil @equipment.errors[:usable], 'no validation error for usable present'
  end
end
