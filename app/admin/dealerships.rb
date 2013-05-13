ActiveAdmin.register Dealership do
  filter :name
  config.sort_order = "name_asc"

  index do
    column :name
    column 'Average Score' do |dealership|
      dealership.users.average('score')
    end
    column 'Average Time Taken' do |dealership|
      dealership.to_time(dealership.users.average('time_taken'))
    end
    default_actions
  end

  show do
    panel "Dealership Details" do
      attributes_table_for dealership do
        row("name") { dealership.name }
        row("users") { dealership.users.count }
        row("Average Score") { dealership.users.average('score') }
        row("Average Time") { dealership.to_time(dealership.users.average('time_taken')) }
      end
    end

    panel "Users" do
      table_for dealership.users do |t|
        t.column("name") { |user| link_to user.first_name + " " + user.last_name, admin_user_path(user) }
        t.column("score") { |user| user.score }
        t.column("Time Taken") { |user| user.the_time }
        t.column("Date") { |user| user.created_at.to_formatted_s(:long) }
      end
    end
  end
end
