# frozen_string_literal: true

module Strategies
  #
  # Simple
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
