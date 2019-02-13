# frozen_string_literal: true

require 'test_helper'

class EquipmentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: equipment
#
#  id           :bigint(8)        not null, primary key
#  usable_type  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  character_id :bigint(8)
#  usable_id    :bigint(8)
#
# Indexes
#
#  index_equipment_on_character_id               (character_id)
#  index_equipment_on_usable_type_and_usable_id  (usable_type,usable_id)
#
