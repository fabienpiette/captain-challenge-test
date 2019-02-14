# frozen_string_literal: true


require 'test_helper'

class ShieldTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @shield = shields(:one)
  end

  #
  # Validations
  #
  test 'valid shield' do
    assert @shield.valid?
  end

  test 'invalid without name' do
    shield      = shields(:one)
    shield.name = nil

    assert_not @shield.valid?, 'shield is valid without a name'
    assert_not_nil @shield.errors[:name], 'no validation error for name present'
  end

  test 'invalid without defense' do
    shield         = shields(:one)
    shield.defense = nil

    assert_not @shield.valid?, 'shield is valid without a defense'
    assert_not_nil @shield.errors[:defense], 'no validation error for defense present'
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
# Table name: shields
#
#  id         :bigint(8)        not null, primary key
#  defense    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
