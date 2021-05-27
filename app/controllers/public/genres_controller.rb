class Public::GenresController < ApplicationController

  def kids
    @kids_shops = Shop.where(genre_id: 1).page(params[:page]).per(10)
  end

  def solo
    @solo_shops = Shop.where(genre_id: 2).page(params[:page]).per(10)
  end

  def date
    @date_shops = Shop.where(genre_id: 3).page(params[:page]).per(10)
  end

  def interior
    @interior_shops = Shop.where(genre_id: 4).page(params[:page]).per(10)
  end

  def pet
    @pot_shops = Shop.where(genre_id: 5).page(params[:page]).per(10)
  end

  def sweets
    @sweets_shops = Shop.where(genre_id: 6).page(params[:page]).per(10)
  end
  
  def alcohol
    @alcohol_shops = Shop.where(genre_id: 7).page(params[:page]).per(10)
  end
end