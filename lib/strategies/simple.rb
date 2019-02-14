# frozen_string_literal: true

module Strategies
  # Simple strategie draws a number between
  # one and six plus the dexterity value
  #
  # @param dexterity [Integer] bonus on the score
  #
  class Simple
    attr_accessor :dexterity

    def initialize(attrs = {})
      @dexterity = attrs.fetch(:dexterity) { 0 }
    end

    def process
      Random.rand(1..6) + @dexterity
    end
  end
end
