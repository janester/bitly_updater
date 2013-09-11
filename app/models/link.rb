# == Schema Information
#
# Table name: links
#
#  id          :integer          not null, primary key
#  url         :string(255)
#  clicks      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  prev_clicks :integer
#  name        :text
#

class Link < ActiveRecord::Base
  attr_accessible :clicks, :name, :url, :prev_clicks
  belongs_to :user
end
