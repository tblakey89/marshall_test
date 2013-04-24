ActiveAdmin.register Section do

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :video_id
      f.input :exam
      f.input :order
    end
    f.actions
  end

end
