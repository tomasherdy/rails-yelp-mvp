class ReviewsController < ApplicationController

  def new
    # precisamos do @restaurant para avisar ao simple form que criaremos
    # "uma review do restaurante", nao apenas "uma review"
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new
  end

  def create
    # como o restaurante nao eh um campo no form, mas sim uma info que esta
    # na url, devemos pega-lo do mesmo jeito que fizemos no #new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = Review.new(review_params)

    # depois de criarmos a review com as infos que o user preencheu no form,
    # precisamos conecta-la ao restaurante que pegamos da url
    @review.restaurant = @restaurant

    if @review.save
      redirect_to restaurant_path(@restaurant)
    else
      render :new
    end
  end

  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy
  #   redirect_to restaurant_path(@review.restaurant)
  # end

  def review_params
    # repare que o :restaurant_id nao esta presente aqui. Nao queremos que
    # o user nos passe essa informacao (pois pegaremos ela da url)
    params.require(:review).permit(:content, :rating)
  end
end
