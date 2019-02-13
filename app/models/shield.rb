# frozen_string_literal: true

class Shield < ApplicationRecord
  #
  # Validations
  #

  #
  # Associations
  #
  has_many :equipments, as: :usables

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

  #
  # Protected instance methods
  #
  # protected
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
