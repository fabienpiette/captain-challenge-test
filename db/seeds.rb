# frozen_string_literal: true

10.times do
  Character.create(
    name: Faker::Games::Witcher.character
  )
end
