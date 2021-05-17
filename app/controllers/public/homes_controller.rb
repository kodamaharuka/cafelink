class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @random = Shop.order('RANDOM()').limit(15)
    @revdom = Post.order('RANDOM()').limit(5)
  end

  def about
    @genres = Genre.all
  end

  def search
    @generes = Genre.all
    @genre = Genre.find(params[:id])
    @shops = @genre.shops
    @shop = Shop.find_by(params[:id])
  end
end
