ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  ActiveAdmin::Dashboards.build do
    section "Dealership Scores" do
      table_for Dealership.find(:all, select: "dealerships.name, dealerships.id, avg(users.score) as average_score, avg(users.time_taken) as average_time", limit: 10, joins: :users, order: 'average_score') do |t|
        t.column ("Dealership") { |dealership| link_to dealership.name, admin_dealership_path(dealership) }
        t.column ("Average Score") { |dealership| dealership.average_score }
        t.column ("Average Time") { |dealership| dealership.to_time(dealership.average_time) }
      end
    end

    section "Latest Users" do
      table_for User.order("created_at desc").limit(10) do |t|
        t.column ("Name") { |user| link_to user.first_name + " " + user.last_name, admin_user_path(user) }
        t.column ("Dealership") { |user| link_to user.dealership.name, admin_dealership_path(user.dealership) }
        t.column ("Score") { |user| user.score }
        t.column ("Time Taken") { |user| user.the_time }
      end
    end
  end

end
