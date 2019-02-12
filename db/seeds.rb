# frozen_string_literal: true

10.times do
  Character.create(
    name: Faker::Witcher.character
  )
end
