class Public::ShopsController < ApplicationController
  
  def index
    @shops = Shop.all.page(params[:page]).per(10)
  end

  def show
    @shop = Shop.find(params[:id])
  end

  private

  def shop_params
    params.require(:shop).permit(
      :genre_id,
      :cafe_name,
      :phone_number,
      :address,
      :nearest_station,
      :business_hours,
      :regular_holiday,
      :image,
      :introduction
      #shop_images_images: []
    )
  end
end
