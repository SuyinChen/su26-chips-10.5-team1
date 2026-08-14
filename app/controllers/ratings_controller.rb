# frozen_string_literal: true

class RatingsController < ApplicationController
  before_action :require_login!

  def create
    news_item = NewsItem.find(params[:news_item_id])
    rating = current_user.ratings.find_or_initialize_by(news_item: news_item)
    rating.value = params[:value]
    rating.save
    redirect_to representative_news_item_path(news_item.representative, news_item)
  end
end
