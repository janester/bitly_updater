class Notifications < ActionMailer::Base
  default from: "janesternbach@gmail.com"
  def confirmation_message(user)
    @user = user
    mail :to => user.email, :subject => "Bitly Link Updater Confirmation"
  end

  def update_message(user, links)
    @user = user
    @links = links
    mail :to => user.email, :subject => "Bitly Link Update"
  end
end
