class SessionController < ApplicationController
  require 'net/http'
  require 'uri'

  def new
  end

  def callback
    client_id="2ef51869c19eb4db55b928013fcde1b3479df980"
    client_secret="3ea14b69ad08614aac6a0e883364b5ed1bdd6e31"
    code = params[:code]
    redirect_uri = "http://localhost:3000/callback/"
    uri = URI.parse('https://api-ssl.bitly.com/oauth/access_token')
    begin
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({'client_id' => client_id, 'client_secret' => client_secret, 'redirect_uri' => redirect_uri, 'code' => code})

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
