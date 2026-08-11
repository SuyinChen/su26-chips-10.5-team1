# frozen_string_literal: true

require 'rails_helper'

describe MyNewsItemsController do
  let!(:user) do
    User.create!(
      first_name: 'Test',
      last_name: 'User',
      provider: :developer,
      uid: '22345'
    )
  end
  let!(:representative) { Representative.create!(name: 'Wilson Jiang') }

  before do
    session[:user_id] = user.id
  end

  describe 'GET new' do
    render_views
    it 'renders the new page' do
      get :new, params: { representative_id: representative.id }

      expect(response).to be_successful
    end
  end

  describe 'POST create' do
    let(:article_params) do
      {
        representative_id: representative.id,
        issue: 'Climate Change',
        article: 'https://example.com/climate',
        articles: {
          '0' => {
            title: 'Climate Article',
            url: 'https://example.com/climate',
            description: 'Climate change news'
          }
        }
      }
    end

    it 'creates news item with an issue' do
      expect do
        post :create, params: article_params
      end.to change(NewsItem, :count).by(1)

      expect(NewsItem.last.issue).to eq('Climate Change')
    end

    it 'saves the article' do
      post :create, params: article_params

      expect(NewsItem.last.title).to eq('Climate Article')
      expect(NewsItem.last.link).to eq('https://example.com/climate')
      expect(NewsItem.last.description).to eq('Climate change news')
      expect(NewsItem.last.representative_id).to eq(representative.id)
    end

    it 'redirects when no article is selected and an alert is shown' do
      post :create, params: article_params.except(:article)

      expect(flash[:alert]).to be_present
      expect(response).to redirect_to(search_my_news_item_path(representative_id: representative.id,
                                                               issue: 'Climate Change'))
    end
  end

  describe 'GET search' do
    render_views
    let(:articles) do
      [
        {
          'title' => 'Climate Article',
          'url' => 'https://example.com/climate',
          'description' => 'Climate change news'
        }
      ]
    end

    let(:client) { instance_double(Currents::Client, search: articles) }

    before do
      allow(Currents::Client).to receive(:new).and_return(client)
    end

    it 'searches for articles using the selected issue' do
      get :search, params: {
        representative_id: representative.id,
        issue: 'Climate Change'
      }

      expect(response).to be_successful
    end
  end
end
