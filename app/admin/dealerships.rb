ActiveAdmin.register Dealership do
  filter :name

  index do
    column :name
    default_actions
  end
end
