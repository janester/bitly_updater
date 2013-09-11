class HomeController < ApplicationController
  def index
  end

  def add_email
    user = User.find(params[:id])
    user.update_attributes(:email => params[:email])
    session[:user].links = user.get_links
    Notifications.confirmation_message(session[:user]).deliver
    flash[:message] = "Your email address has been saved. A confirmation email has been sent. And you begin recieving daily updates on your bitly links"
    redirect_to(root_path)
  end
end
