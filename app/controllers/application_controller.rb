class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def authenticate
    unless session[:user_id].nil?
      @cu = User.find(session[:user_id])
    end
  end
end
