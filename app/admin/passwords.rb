ActiveAdmin.register Password do

  config.filters = false

  controller do
    actions :all, except: [:destroy, :new, :show]
  end

  index do
    column :password
    default_actions
  end
end
