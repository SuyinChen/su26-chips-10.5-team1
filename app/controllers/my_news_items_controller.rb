# frozen_string_literal: true

class MyNewsItemsController < ApplicationController
  before_action :require_login!

  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def search
    @issue = params[:issue]
    currents_api_key = ENV.fetch('CURRENTS_API_KEY', Rails.application.credentials[:CURRENTS_API_KEY])
    client = Currents::Client.new(currents_api_key)
    @articles = client.search(@issue).first(5)
  end

  def edit; end

  def create
    if params[:article].blank?
      redirect_to search_my_news_item_path(representative_id: @representative.id,
                                           issue: params[:issue]),
                  alert: 'For saving, please select an article.'
      return
    end
    selected = params[:articles].values.find do |article|
      article[:url] == params[:article]
    end
    @news_item = NewsItem.new(title: selected[:title], link: selected[:url],
                              description: selected[:description],
                              issue: params[:issue],
                              representative_id: @representative.id)
    if @news_item.save
      create_rating(@news_item)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  def news_item_params
    params.require(:news_item).permit(:title, :issue, :description, :link, :representative_id)
  end

  def create_rating(news_item)
    return if params[:rating].blank?
    rating = current_user.ratings.find_or_initialize_by(news_item: news_item)
    rating.value = params[:rating]
    rating.save
  end
end
