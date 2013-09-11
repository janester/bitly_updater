class HomeController < ApplicationController
  def index
    @client_id="2ef51869c19eb4db55b928013fcde1b3479df980"
    @client_secret="3ea14b69ad08614aac6a0e883364b5ed1bdd6e31"
  end

  def add_email
    binding.pry
  end
end
