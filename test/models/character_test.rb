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

  test 'invalid without dexterity' do
    character = characters(:one)
    character.dexterity = nil

    assert_not @character.valid?,
               'character is valid without a dexterity'
    assert_not_nil @character.errors[:dexterity],
                   'no validation error for dexterity present'
  end

  test 'invalid without constitution' do
    character = characters(:one)
    character.constitution = nil

    assert_not @character.valid?,
               'character is valid without a constitution'
    assert_not_nil @character.errors[:constitution],
                   'no validation error for constitution present'
  end

  test 'invalid without gladiator_type' do
    character = characters(:one)
    character.gladiator_type = nil

    assert_not @character.valid?,
               'character is valid without a gladiator_type'
    assert_not_nil @character.errors[:gladiator_type],
                   'no validation error for gladiator_type present'
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
#  id                :bigint(8)        not null, primary key
#  attack_points     :integer          default(1), not null
#  capacity_points   :integer          default(0), not null
#  constitution      :integer          default(1), not null
#  dexterity         :integer          default(1), not null
#  health_points     :integer          default(20), not null
#  level             :integer          default(1), not null
#  name              :string           not null
#  xp_points         :integer          default(0), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  gladiator_type_id :bigint(8)
#  user_id           :bigint(8)
#
# Indexes
#
#  index_characters_on_gladiator_type_id  (gladiator_type_id)
#  index_characters_on_user_id            (user_id)
#
