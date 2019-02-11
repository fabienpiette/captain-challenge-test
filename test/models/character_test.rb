# frozen_string_literal: true

require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @character = characters(:one)
  end

  #
  # Validations
  #
  test 'valid character' do
    assert @character.valid?
  end

  test 'invalid without name' do
    character = characters(:one)
    character.name = nil

    assert_not @character.valid?, 'character is valid without a name'
    assert_not_nil @character.errors[:name], 'no validation error for name present'
  end

  test 'invalid without health_points' do
    character = characters(:one)
    character.health_points = nil

    assert_not @character.valid?,
               'character is valid without a health_points'
    assert_not_nil @character.errors[:health_points],
                   'no validation error for health_points present'
  end

  test 'invalid without attack_points' do
    character = characters(:one)
    character.attack_points = nil

    assert_not @character.valid?,
               'character is valid without a attack_points'
    assert_not_nil @character.errors[:attack_points],
                   'no validation error for attack_points present'
  end

  test 'invalid when health_points is greater than 9 on create' do
    character = Character.create(
      name: 'Foo',
      health_points: 10,
      attack_points: 6
    )

    assert_not character.valid?,
               'character is valid when health_points is greater than 9'
    assert_not_nil character.errors[:health_points],
                   'validation error for health_points invalid value'
  end

  test 'invalid when health_points is less than 1 on create' do
    character = Character.create(
      name: 'Foo',
      health_points: 0,
      attack_points: 6
    )

    assert_not character.valid?,
               'character is valid when health_points is less than 0'
    assert_not_nil character.errors[:health_points],
                   'validation error for health_points invalid value'
  end

  test 'invalid when attack_points is greater than 9 on create' do
    character = Character.create(
      name: 'Foo',
      health_points: 5,
      attack_points: 10
    )

    assert_not character.valid?,
               'character is valid when attack_points is greater than 9'
    assert_not_nil character.errors[:attack_points],
                   'validation error for attack_points invalid value'
  end

  test 'invalid when attack_points is less than 1 on create' do
    character = Character.create(
      name: 'Foo',
      health_points: 5,
      attack_points: 0
    )

    assert_not character.valid?,
               'character is valid when attack_points is less than 0'
    assert_not_nil character.errors[:attack_points],
                   'validation error for attack_points invalid value'
  end

  test 'invalid when character is unbalanced' do
    character = Character.create(
      name: 'Foo',
      health_points: 5,
      attack_points: 6
    )

    assert_not character.valid?
    assert_not_nil character.errors[:base]
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
  # test '#foo' do
  # end
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
