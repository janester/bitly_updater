namespace "bu" do
  desc "Sends link update"
  task :send_update => :environment do
    User.all.each do |user|
      user.get_links
      updated_links = user.updated_links
      puts updated_links.map(&:name)
      unless updated_links.empty?
        Notifications.update_message(user, updated_links).deliver
      end
    end
  end
end

