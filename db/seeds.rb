# frozen_string_literal: true

datas = YAML.safe_load(
  File.open(Rails.root.join('db', 'datas', 'import', 'types.yml'))
)
datas.each do |data|
  # picture_name = data.delete('picture')
  # path = Rails.root.join('db', 'datas', 'images', picture_name)
  GladiatorType.create!(data)
  # type.avatar.attach(io: File.open(path), filename: picture_name)
end

10.times do
  Character.create!(
    name: Faker::Games::Witcher.character,
    gladiator_type: GladiatorType.all.sample
  )
end

Weapon.create(
  name: 'Thracian curved sword',
  damage: 1
)

Weapon.create(
  name: 'Gladius',
  damage: 1
)

Weapon.create(
  name: 'Trident',
  damage: 1
)

Shield.create(
  name: 'Small round shield',
  defense: 1
)

Shield.create(
  name: 'Oblong shield',
  defense: 2
)

Administrator.create(
  email: 'admin@example.com',
  password: 'password',
  first_name: 'Admin',
  last_name: 'User'
)
