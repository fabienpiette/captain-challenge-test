# frozen_string_literal: true

class Character < ApplicationRecord
  #
  # Active Storage
  #
  has_one_attached :avatar

  #
  # Validations
  #
  validates :name,
            :health_points,
            :attack_points,
            :dexterity,
            :constitution,
            presence: true

  #
  # Associations
  #
  belongs_to :owner,
             class_name: 'User',
             foreign_key: 'user_id',
             inverse_of: :characters,
             optional: true

  belongs_to :gladiator_type,
             class_name: 'GladiatorType',
             foreign_key: 'gladiator_type_id',
             inverse_of: :characters

  has_many :equipments,
           class_name: 'Equipment',
           foreign_key: 'character_id',
           dependent: :destroy,
           inverse_of: :character
  accepts_nested_attributes_for :equipments

  has_many :left_fights,
           class_name: 'Fight',
           foreign_key: 'fighter_left_id',
           dependent: :destroy,
           inverse_of: :fighter_left

  has_many :right_fights,
           class_name: 'Fight',
           foreign_key: 'fighter_right_id',
           dependent: :destroy,
           inverse_of: :fighter_right

  has_many :won_battles,
           class_name: 'Fight',
           foreign_key: 'winning_character_id',
           dependent: :destroy,
           inverse_of: :winning_character

  has_many :lost_battles,
           class_name: 'Fight',
           foreign_key: 'losing_character_id',
           dependent: :destroy,
           inverse_of: :losing_character

  #
  # Through Associations
  #
  has_many :weapons,
           class_name: 'Weapon',
           through: :equipments,
           source: :usable,
           source_type: 'Weapon'

  has_many :shields,
           class_name: 'Shield',
           through: :equipments,
           source: :usable,
           source_type: 'Shield'

  #
  # Callbacks
  #
  before_validation :define_points, on: :create
  after_save :check_xp

  #
  # Scopes
  #

  #
  # Supports
  #

  #
  # Public class methods
  #
  def fights
    Fight.where('fighter_left_id = ? OR fighter_right_id = ?', id, id)
  end

  def fight_strategy
    Strategies::Simple.new(
      dexterity: dexterity
    )
  end

  def damage
    return attack_points if weapons.blank?

    attack_points + weapons.first.damage
  end

  def defense
    constitution + shields.sum(:defense)
  end

  #
  # Public instance methods
  #

  #
  # Protected instance methods
  #
  # protected
  #
  def define_points
    self.attack_points = gladiator_type&.base_attack_points
    self.health_points = gladiator_type&.base_health_points
    self.dexterity     = gladiator_type&.dexterity
    self.constitution  = gladiator_type&.constitution
  end

  def check_xp
    if xp_points >= 10
      capacity_points += 1
      level           += 1
      xp_points = 0
      save
    end
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
