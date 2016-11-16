class FavoriteAdsController < ApplicationController
  before_action :set_ads, :authenticate_user!
   
  def create
    if Favorite.create(favorited: @ad, user: current_user)
      redirect_to :back, notice: 'Anúncio favoritado com sucesso!'
    else
      redirect_to :back, alert: 'Something went wrong...*sad panda*'
    end
  end
  
  def destroy
    Favorite.where(favorited_id: @ad.id, user_id: current_user.id).first.destroy
    redirect_to :back, notice: 'Project is no longer in favorites'
  end
  
  private
  
  def set_ads
    @ad = Ad.friendly.find(params[:ad_id] || params[:id])
  end
end
