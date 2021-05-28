class Public::GenresController < ApplicationController

  def kids
    @kids_shops = Shop.where(genre_id: 6).page(params[:page]).per(10)
  end

  def solo
    @solo_shops = Shop.where(genre_id: 7).page(params[:page]).per(10)
  end

  def date
    @date_shops = Shop.where(genre_id: 8).page(params[:page]).per(10)
  end
  
  def interior
    @interior_shops = Shop.where(genre_id: 9).page(params[:page]).per(10)
  end

  def pet
    @pet_shops = Shop.where(genre_id: 10).page(params[:page]).per(10)
  end

  def sweets
    @sweets_shops = Shop.where(genre_id: 11).page(params[:page]).per(10)
  end
  
  def alcohol
    @alcohol_shops = Shop.where(genre_id: 12).page(params[:page]).per(10)
  end
end