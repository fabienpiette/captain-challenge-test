# frozen_string_literal: true

module Strategies
  #
  # Simple
  #
  class Simple
    def process
      Random.rand(1..6)
    end
  end
end
