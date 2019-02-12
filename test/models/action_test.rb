# frozen_string_literal: true

require 'test_helper'

class ActionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
