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

  #
  # Supports
  #

  #
  # Public class methods
  #

  #
  # Public instance methods
  #
  # def process
  #   while fighter_left.alive? && fighter_right.alive?
  #     fighter_left_score  = fighter_left.fight_strategy.process
  #     fighter_right_score = fighter_right.fight_strategy.process
  #     if fighter_left_score > fighter_right_score
  #       Rails.logger.info 'Hero touch'
  #       fighter_right.wound(fighter_left.damage)
  #     elsif fighter_left_score < fighter_right_score
  #       Rails.logger.info 'Monster touch'
  #       fighter_left.wound(fighter_right.damage)
  #     elsif fighter_left_score == fighter_right_score
  #       # Nothing
  #       Rails.logger.info 'Miss'
  #     end
  #   end
  #   Rails.logger.info 'Fight ending'
  # end

  def launch
    Rails.logger.info "-- Launch fight between #{fighter_left.name} and #{fighter_right.name}"

    actions.create(
      left_hp: fighter_left.health_points,
      right_hp: fighter_right.health_points
    )
  end

  def take_turn
    return if finished?

    if fighter_left_score > fighter_right_score
      wound(fighter_right, fighter_left.damage, :right)
    elsif fighter_left_score < fighter_right_score
      wound(fighter_left, fighter_right.damage, :left)
    elsif fighter_left_score == fighter_right_score
      miss
    end

    clean
    finished if finished?
  end

  def launched?
    actions.count > 0
  end

  def finished?
    dead?(fighter_left) || dead?(fighter_right)
  end

  def winner
    return fighter_left if dead?(fighter_right) && alive?(fighter_left)

    fighter_right if dead?(fighter_left) && alive?(fighter_right)
  end

  def loser
    return fighter_left if dead?(fighter_left) && alive?(fighter_right)

    fighter_right if dead?(fighter_right) && alive?(fighter_left)
  end

  #
  # Protected instance methods
  #
  protected

  def finished
    update(
      winning_character: winner,
      losing_character: loser
    )
  end

  def clean
    @fighter_left_score  = nil
    @fighter_right_score = nil
  end

  def wound(character, damage, side)
    Rails.logger.info "-- #{character.name} touch with #{damage} damage."

    opposite = opposite_character(character)

    action = actions.build(
      damage: damage,
      fighter_left_score: fighter_left_score,
      fighter_right_score: fighter_right_score,
      character: opposite
    )
    action.send(
      "#{side}_hp=",
      health_points(character) - damage
    )
    action.send(
      "#{opposite_side(side)}_hp=",
      health_points(opposite)
    )
    action.save
  end

  def miss
    Rails.logger.info '-- Miss'

    actions.create(
      fighter_left_score: fighter_left_score,
      fighter_right_score: fighter_right_score,
      left_hp: health_points(fighter_left),
      right_hp: health_points(fighter_right)
    )
  end

  def fighter_left_score
    @fighter_left_score ||= fighter_left.fight_strategy.process
  end

  def fighter_right_score
    @fighter_right_score ||= fighter_right.fight_strategy.process
  end

  def health_points(character)
    character.health_points - actions.opponent(character).sum(&:damage)
  end

  def dead?(character)
    health_points(character) <= 0
  end

  def alive?(character)
    health_points(character) > 0
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
