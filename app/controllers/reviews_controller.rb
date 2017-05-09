class ReviewsController < ApplicationController

  def index
    @reviews = Review.all.sort_by { |review| review.unit_location }
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to @review
    else
      render :new
    end
  end

  def show
    @review = Review.find_by(id: params[:id])
  end

  def edit
    @review = Review.find_by(id: params[:id])
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @review.update(review_params)
      redirect_to @review
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(
      :comment,
      { :ratings => [ :quality, :helpfulness, :frustration, :time_taken ] },
      { :tags => :progress }
      )
  end

end
