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
  test '#fights' do
    assert_includes @character.fights, fights(:one)
    refute_includes @character.fights, fights(:three)
  end

  test '#fight_strategy' do
    assert_instance_of Strategies::Simple, @character.fight_strategy
  end

  test '#damage without weapons' do
    @character.attack_points = 2

    assert_equal @character.damage, 2
  end

  test '#damage with weapons' do
    @character.attack_points = 2
    @character.weapons << weapons(:one)
    @character.weapons << weapons(:one)

    assert_equal @character.damage, 4
  end

  test '#defense without shields' do
    @character.constitution = 2

    assert_equal @character.defense, 2
  end

  test '#defense with shields' do
    @character.constitution = 2
    @character.shields << shields(:one)
    @character.shields << shields(:one)

    assert_equal @character.defense, 4
  end

  #
  # Protected instance methods
  #
  #
  test '#define_points' do
    character = Character.new(name: 'Foo')
    gladiator = gladiator_types(:foo)

    character.gladiator_type = gladiator

    assert_equal character.attack_points, 1
    assert_equal character.health_points, 20
    assert_equal character.dexterity, 1
    assert_equal character.constitution, 1

    character.save

    assert_equal character.attack_points, gladiator.base_attack_points
    assert_equal character.health_points, gladiator.base_health_points
    assert_equal character.dexterity, gladiator.dexterity
    assert_equal character.constitution, gladiator.constitution
  end

  test '#check_xp, increment capacity_points when enought XP' do
    character                 = characters(:one)
    character.xp_points       = 10
    character.capacity_points = 0
    character.level           = 1

    assert_difference 'character.capacity_points', 1 do
      character.save
    end
  end

  test '#check_xp, increment level when enought XP' do
    character                 = characters(:one)
    character.xp_points       = 10
    character.capacity_points = 0
    character.level           = 1

    assert_difference 'character.level', 1 do
      character.save
    end
  end

  test '#check_xp, reset XP' do
    character                 = characters(:one)
    character.xp_points       = 10
    character.capacity_points = 0
    character.level           = 1

    character.save
    assert_equal character.xp_points, 0
  end
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
