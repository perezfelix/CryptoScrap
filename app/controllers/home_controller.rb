class HomeController < ApplicationController
  def index

  end

  def show
  	show_crypto
  	StartScrap.new.update
  end
  def create
  	StartScrap.new.perform
  	redirect_to root_path
  end



private
  def show_crypto
	@crypto = Crypto.find(params[:Crypto][:crypto_id])
  end



  def crypto_params
    params.require(:@crypto).permit(:Crypto[:crypto_id], :name, :price)
  end
end
