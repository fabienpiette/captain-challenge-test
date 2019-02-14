# frozen_string_literal: true

Trestle.resource(:gladiator_types) do
  menu do
    item :gladiator_types, icon: 'fa fa-star'
  end

  active_storage_fields do
    [:avatar]
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  form do |gladiator_type|
    text_field :name
    text_area :description
    number_field :base_attack_points
    number_field :base_health_points
    number_field :constitution
    number_field :dexterity
    active_storage_field :avatar
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:gladiator_type).permit(:name, ...)
  # end
end
