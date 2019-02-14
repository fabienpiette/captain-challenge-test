# frozen_string_literal: true

class Fight < ApplicationRecord
  #
  # Validations
  #

  #
  # Associations
  #
  belongs_to :fighter_left,
             class_name: 'Character',
             foreign_key: 'fighter_left_id',
             inverse_of: :left_fights

  belongs_to :fighter_right,
             class_name: 'Character',
             foreign_key: 'fighter_right_id',
             inverse_of: :right_fights

  belongs_to :winning_character,
             class_name: 'Character',
             foreign_key: 'winning_character_id',
             inverse_of: :won_battles,
             optional: true

  belongs_to :losing_character,
             class_name: 'Character',
             foreign_key: 'losing_character_id',
             inverse_of: :lost_battles,
             optional: true

  has_many :actions,
           class_name: 'Action',
           foreign_key: 'fight_id',
           dependent: :destroy,
           inverse_of: :fight

  #
  # Through Associations
  #

  #
  # Callbacks
  #

  #
  # Scopes
  #
  scope :won, lambda { |character|
    where(winning_character: character)
  }

  scope :loses, lambda { |character|
    where(losing_character_id: character)
  }

  #
  # Supports
  #

  #
  # Public class methods
  #

  #
  # Public instance methods
  #
  def launch
    actions.create(
      left_hp: fighter_left.health_points,
      right_hp: fighter_right.health_points
    )
  end

  def take_turn(
    left_score = fighter_left_score,
    right_score = fighter_right_score
  )
    return false unless take_turn?

    if left_score > right_score
      wound(fighter_left, fighter_right, :right)
    elsif right_score > left_score
      wound(fighter_right, fighter_left, :left)
    elsif left_score == right_score
      miss
    end

    finished if finished?
    true
  end

  def clean
    @fighter_left_score  = nil
    @fighter_right_score = nil
  end

  def launched?
    actions.count.positive?
  end

  def finished?
    dead?(fighter_left) || dead?(fighter_right)
  end

  def percent_hp(character)
    (health_points(character) * 100) / character.health_points
  end

  def health_points(character)
    character.health_points - actions.with_fighter(opposite_character(character)).sum(&:damage)
  end

  def name
    "#{fighter_left&.name} VS #{fighter_right&.name}"
  end

  def fighter_left_score
    @fighter_left_score || fighter_left.fight_strategy.process
  end

  def fighter_right_score
    @fighter_right_score || fighter_right.fight_strategy.process
  end

  #
  # Protected instance methods
  #
  protected

  def take_turn?
    !finished? && launched?
  end

  def dead?(character)
    health_points(character) <= 0
  end

  def alive?(character)
    health_points(character).positive?
  end

  def winner
    return fighter_left if dead?(fighter_right) && alive?(fighter_left)

    fighter_right if dead?(fighter_left) && alive?(fighter_right)
  end

  def loser
    return fighter_left if dead?(fighter_left) && alive?(fighter_right)

    fighter_right if dead?(fighter_right) && alive?(fighter_left)
  end

  def damage_with(attacker, defender)
    damage = attacker.damage - defender.defense
    damage = 0 if damage.negative?
    damage
  end

  def finished
    update(
      winning_character: winner,
      losing_character: loser
    )
    winning_character.xp_points += 2
    losing_character.xp_points  += 1

    winning_character.save
  end

  def wound(attacker, defender, defender_side, damage = nil)
    damage ||= damage_with(attacker, defender)

    action = actions.build(
      damage: damage,
      fighter_left_score: fighter_left_score,
      fighter_right_score: fighter_right_score,
      character: attacker
    )

    action.send("#{defender_side}_hp=", health_points(defender) - damage)
    action.send("#{opposite_side(defender_side)}_hp=", health_points(attacker))
    action.save
    action
  end

  def miss
    actions.create(
      fighter_left_score: fighter_left_score,
      fighter_right_score: fighter_right_score,
      left_hp: health_points(fighter_left),
      right_hp: health_points(fighter_right)
    )
  end

  def opposite_side(side)
    return :left if side == :right

    :right if side == :left
  end

  def opposite_character(character)
    return fighter_left if character == fighter_right

    fighter_right if character == fighter_left
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
