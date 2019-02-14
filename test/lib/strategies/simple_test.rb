require 'test_helper'

class Strategies::SimpleTest < ActiveSupport::TestCase
  test 'get number between one and six' do
    strategie = Strategies::Simple.new

    10.times do
      assert strategie.process <= 6
    end
  end

  test 'get number between one and the given dexterity + six' do
    strategie = Strategies::Simple.new(dexterity: 20)

    10.times do
      assert strategie.process <= 26
    end
  end
end
