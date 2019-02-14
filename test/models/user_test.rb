# frozen_string_literal: true


require 'test_helper'

class UserTest < ActiveSupport::TestCase
  #
  # Setups
  #
  def setup
    @user = users(:one)
  end

  #
  # Validations
  #
  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without email' do
    user = users(:one)
    user.email = nil

    assert_not @user.valid?, 'user is valid without a email'
    assert_not_nil @user.errors[:email], 'no validation error for email present'
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

  #
  # Protected instance methods
  #
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
