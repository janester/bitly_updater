class HomeController < ApplicationController
  def index
  end

  def add_email
    @cu.update_attributes(:email => params[:email])
    @cu.links = @cu.get_links
    Notifications.confirmation_message(@cu).deliver
    flash[:message] = "Your email address has been saved. A confirmation email has been sent. And you begin recieving daily updates on your bitly links"
    redirect_to(root_path)
  end
end
