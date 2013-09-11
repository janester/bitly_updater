class SessionController < ApplicationController
  require 'net/http'
  require 'uri'

  def new
  end

  def callback

    code = params[:code]
    begin
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({'client_id' => ENV["CLIENT_ID"], 'client_secret' => ENV["CLIENT_SECRET"], 'redirect_uri' => ENV["REDIRECT_URI"], 'code' => code})

      response = https.request(request)

      puts "#{response.code} -- #{response.body}" #sanity check
      @data = {}
      response.body.split('&').each do |pair|
        a = pair.split('=')
        @data[a[0].to_sym] = a[1]
      end
      user = User.find_by_login(@data[:login])
      if user.nil?
        @user = User.create(login:@data[:login], access_token:@data[:access_token], apikey:@data[:apiKey])
      else
        @user = user.update_attributes(access_token:@data[:access_token], apikey:@data[:apiKey])
      end
      session[:user] = @user
    rescue
    end
    redirect_to(root_path)
  end


  def destroy
  end
end
