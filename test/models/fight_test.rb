# frozen_string_literal: true

require 'test_helper'

class FightTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
