# frozen_string_literal: true


require 'test_helper'

class FightTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @fight = fights(:one)
  end

  #
  # Validations
  #
  test 'valid fight' do
    assert @fight.valid?
  end

  test 'invalid without fighter_left' do
    fight              = fights(:one)
    fight.fighter_left = nil

    assert_not @fight.valid?, 'fight is valid without a fighter_left'
    assert_not_nil @fight.errors[:fighter_left], 'no validation error for fighter_left present'
  end

  test 'invalid without fighter_right' do
    fight               = fights(:one)
    fight.fighter_right = nil

    assert_not @fight.valid?, 'fight is valid without a fighter_right'
    assert_not_nil @fight.errors[:fighter_right], 'no validation error for fighter_right present'
  end

  #
  # Associations
  #

  #
  # Scopes
  #
  test '#won' do
    fight                   = fights(:one)
    fight.winning_character = fight.fighter_left
    fight.save

    assert_includes Fight.won(fight.fighter_left), fight
    assert_not_includes Fight.won(fight.fighter_left), fights(:two)
  end

  test '#loses' do
    fight = fights(:one)
    fight.losing_character = fight.fighter_left
    fight.save

    assert_includes Fight.loses(fight.fighter_left), fight
    assert_not_includes Fight.loses(fight.fighter_left), fights(:two)
  end

  #
  # Public class methods
  #

  #
  # Public instance methods
  #
  test 'launch' do
    fight = fights(:one)

    assert_difference 'fight.actions.count', 1 do
      fight.launch
    end

    assert_equal fight.actions.last.left_hp, fight.fighter_left.health_points
    assert_equal fight.actions.last.right_hp, fight.fighter_right.health_points
  end

  test 'take_turn return false if fight is not launched' do
    fight = fights(:three)

    assert_not fight.take_turn
  end

  test 'take_turn return false if fight is over' do
    fight = fights(:three)
    fight.fighter_left.health_points  = 5
    fight.fighter_right.health_points = 5
    fight.launch
    fight.send(:wound, fight.fighter_right, fight.fighter_left, :left, 5)

    assert_not fight.take_turn
  end

  test 'take_turn, fighter left touch' do
    fight = fights(:one)

    fight.fighter_left.update(
      attack_points: 2,
      dexterity: 6
    )

    fight.fighter_right.update(
      constitution: 0,
      dexterity: 0
    )

    fight.launch

    assert_difference 'fight.health_points(fight.fighter_right)', -2 do
      fight.take_turn
    end

    assert fight.send(:fighter_left_score) > fight.send(:fighter_right_score)
  end

  test 'take_turn, fighter right touch' do
    fight = fights(:one)

    fight.fighter_right.update(
      attack_points: 2,
      dexterity: 6
    )

    fight.fighter_left.update(
      constitution: 0,
      dexterity: 0
    )

    fight.launch

    assert_difference 'fight.health_points(fight.fighter_left)', -2 do
      fight.take_turn
    end

    assert fight.send(:fighter_right_score) > fight.send(:fighter_left_score)
  end

  test 'take_turn, when the game is over, defines the winner and loser' do
    fight = fights(:one)

    fight.fighter_right.update(
      attack_points: 10,
      dexterity: 6
    )

    fight.fighter_left.update(
      constitution: 0,
      dexterity: 0,
      health_points: 1
    )

    fight.launch
    fight.take_turn

    assert_not_nil fight.winning_character
    assert_not_nil fight.losing_character
    assert_equal fight.winning_character, fight.fighter_right
    assert_equal fight.losing_character, fight.fighter_left
  end

  test 'take_turn, when the game is over, assigns the Xp to the winner' do
    fight = fights(:one)

    fight.fighter_right.update(
      attack_points: 10,
      dexterity: 6
    )

    fight.fighter_left.update(
      constitution: 0,
      dexterity: 0,
      health_points: 1
    )

    fight.launch

    assert_difference 'fight.fighter_right.xp_points', 2 do
      fight.take_turn
    end
  end

  test 'take_turn, when the game is over, assigns the Xp to the looser' do
    fight = fights(:one)

    fight.fighter_right.update(
      attack_points: 10,
      dexterity: 6,
      xp_points: 0
    )

    fight.fighter_left.update(
      constitution: 0,
      dexterity: 0,
      health_points: 1,
      xp_points: 0
    )

    fight.launch

    assert_difference 'fight.fighter_left.xp_points', 1 do
      fight.take_turn
    end
  end

  test 'launched?, return true if is launched' do
    fight = fights(:three)
    fight.launch

    assert fight.launched?
  end

  test 'launched?, return false if is not launched' do
    fight = fights(:three)

    assert_not fight.launched?
  end

  test 'finished?' do
    fight = fights(:one)
    fight.fighter_left.health_points  = 5
    fight.fighter_right.health_points = 5
    fight.launch
    fight.send(:wound, fight.fighter_right, fight.fighter_left, :left, 5)

    assert fight.finished?
  end

  test 'percent_hp' do
    fight = fights(:one)
    fight.fighter_left.health_points  = 5
    fight.fighter_right.health_points = 5
    fight.launch
    fight.send(:wound, fight.fighter_right, fight.fighter_left, :left, 3)

    assert_equal 40, fight.percent_hp(fight.fighter_left)
    assert_equal 100, fight.percent_hp(fight.fighter_right)
  end

  test 'health_points' do
    fight = fights(:one)
    fight.fighter_left.health_points  = 5
    fight.fighter_right.health_points = 5
    fight.launch

    fight.send(:wound, fight.fighter_right, fight.fighter_left, :left, 3)

    assert_equal 2, fight.health_points(fight.fighter_left)
    assert_equal 5, fight.health_points(fight.fighter_right)
  end

  test 'name' do
    fight = fights(:one)

    assert_equal "#{fight.fighter_left.name} VS #{fight.fighter_right.name}", fight.name
  end

  #
  # Protected instance methods
  #
  test 'wound' do
    fight = fights(:one)
    fight.fighter_left.health_points  = 5
    fight.fighter_right.health_points = 5
    fight.launch

    action = fight.send(
      :wound,
      fight.fighter_right,
      fight.fighter_left,
      :left,
      3
    )

    assert_equal action.damage, 3
    assert_not_nil action.fighter_left_score
    assert_not_nil action.fighter_right_score
    assert_equal action.character, fight.fighter_right
  end
end

# == Schema Information
#
# Table name: fights
#
#  id                   :bigint(8)        not null, primary key
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  fighter_left_id      :bigint(8)
#  fighter_right_id     :bigint(8)
#  losing_character_id  :bigint(8)
#  winning_character_id :bigint(8)
#
# Indexes
#
#  index_fights_on_fighter_left_id       (fighter_left_id)
#  index_fights_on_fighter_right_id      (fighter_right_id)
#  index_fights_on_losing_character_id   (losing_character_id)
#  index_fights_on_winning_character_id  (winning_character_id)
#
