ActiveAdmin.register Section do

  controller do
    actions :all, :except => [:destroy, :new]
  end

  filter :name

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :video_id
    end
    f.actions
  end

end
