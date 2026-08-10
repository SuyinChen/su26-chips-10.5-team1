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
    it 'creates news item with an issue' do
      expect do
        post :create, params: { representative_id: representative.id, news_item: { title: 'Test Article', link: 'https://example.com', description: 'description test', representative_id: representative.id, issue: 'Climate Change' } }
      end.to change(NewsItem, :count).by(1)

      expect(NewsItem.last.issue).to eq('Climate Change')
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
