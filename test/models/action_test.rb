# frozen_string_literal: true

require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @action = actions(:one)
  end

  #
  # Validations
  #
  test 'valid action' do
    assert @action.valid?
  end

  test 'invalid without fighter_left_score' do
    action = actions(:one)
    action.fighter_left_score = nil

    assert_not @action.valid?, 'action is valid without a fighter_left_score'
    assert_not_nil @action.errors[:fighter_left_score], 'no validation error for fighter_left_score present'
  end

  test 'invalid without fighter_right_score' do
    action = actions(:one)
    action.fighter_right_score = nil

    assert_not @action.valid?, 'action is valid without a fighter_right_score'
    assert_not_nil @action.errors[:fighter_right_score], 'no validation error for fighter_right_score present'
  end

  test 'invalid without fight' do
    action = actions(:one)
    action.fight = nil

    assert_not @action.valid?, 'action is valid without a fight'
    assert_not_nil @action.errors[:fight], 'no validation error for fight present'
  end

  #
  # Scopes
  #
  # test '#opponent' do
  #   character         = characters(:one)
  #   @action.character = character
  #   assert_includes Action.opponent(character), @action
  #   refute_includes Action.opponent(character), actions(:two)
  # end
  test '#with_fighter' do
    character         = characters(:one)
    @action.character = character

    assert_includes Action.with_fighter(character), @action
    assert_not_includes Action.with_fighter(character), actions(:two)
  end
end

# == Schema Information
#
# Table name: actions
#
#  id                  :bigint(8)        not null, primary key
#  damage              :integer          default(0)
#  fighter_left_score  :integer          default(0)
#  fighter_right_score :integer          default(0)
#  left_hp             :integer          default(0)
#  right_hp            :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  current_fighter_id  :bigint(8)
#  fight_id            :bigint(8)
#
# Indexes
#
#  index_actions_on_current_fighter_id  (current_fighter_id)
#  index_actions_on_fight_id            (fight_id)
#
