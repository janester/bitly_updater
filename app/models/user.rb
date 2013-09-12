# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  access_token    :string(255)
#  login           :string(255)
#  apikey          :string(255)
#  first           :string(255)
#  last            :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :email, :password_digest, :login, :access_token, :apikey, :first, :last
  has_many :links

  def self.api_call(url)
    encoded_url = URI.encode(url)
    HTTParty.get(encoded_url)
  end


  def self.create_with_oauth(data)
    user = User.find_or_initialize_by_login(data[:login])
    user.update_attributes(access_token:data[:access_token], apikey:data[:apiKey])
    user.get_name
    return user
  end


  def get_links
    response = User.api_call("https://api-ssl.bitly.com/v3/user/link_history?format=json&access_token=#{self.access_token}")
    link_list = []
    response["data"]["link_history"].each do |link|
      link["keyword_link"].nil? ? real_link = link["link"] : real_link = link["keyword_link"]
      l = Link.find_or_initialize_by_url(real_link)
      link["title"].nil? ? title = link["long_url"] : title = link["title"]
      response = User.api_call("https://api-ssl.bitly.com/v3/link/clicks?link=#{link["link"]}&unit=day&units=-1&format=json&access_token=#{self.access_token}")
      clicks = response["data"]["link_clicks"]
      l.update_attributes(clicks:clicks, name:title, prev_clicks:l.clicks)
      link_list << l
    end
    link_list
  end

  def get_name
    response = User.api_call("https://api-ssl.bitly.com/v3/user/info?format=json&access_token=#{self.access_token}")
    name = response["data"]["full_name"].split(" ")
    update_attributes(first:name[0], last:name[1])
  end

  def updated_links
    link_list = []
    binding.pry
    self.links.each do |link|
      if link.clicks != link.prev_clicks
        link_list << link
      end
    end
    link_list
  end


end
