class SessionController < ApplicationController
  require 'net/http'
  require 'uri'

  def new
  end

  def callback
    code = params[:code]

    uri = URI.parse('https://api-ssl.bitly.com/oauth/access_token')
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(uri.request_uri)
    request.set_form_data({'client_id' => ENV["CLIENT_ID"], 'client_secret' => ENV["CLIENT_SECRET"], 'redirect_uri' => ENV["REDIRECT_URI"], 'code' => code})

    response = https.request(request)

    puts "#{response.code} -- #{response.body}" #sanity check
    data = {}
    response.body.split('&').each do |pair|
      a = pair.split('=')
      data[a[0].to_sym] = a[1]
    end
    session[:user_id] = User.create_with_oauth(data).id

    redirect_to(root_path)
  end


  def destroy
  end
end
