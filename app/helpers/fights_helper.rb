# frozen_string_literal: true

module FightsHelper
  def score_color(left_score, right_score)
    return 'text-success' if left_score > right_score
    return 'text-danger' if right_score > left_score

    'text-info'
  end
end
