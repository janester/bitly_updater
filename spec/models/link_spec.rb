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

require 'spec_helper'

describe Link do
  pending "add some examples to (or delete) #{__FILE__}"
end
