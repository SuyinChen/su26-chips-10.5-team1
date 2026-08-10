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
    it 'renders the new page' do
      get :new, params: { representative_id: representative.id }

      expect(response).to be_successful
    end
  end

  describe 'POST create' do
  it 'creates news item with an issue' do
    expect {
      post :create, params: {
        representative_id: representative.id,
        news_item: {
          title: 'Test Article',
          link: 'https://example.com',
          description: 'description test',
          representative_id: representative.id,
          issue: 'Climate Change'
        }
      }
    }.to change(NewsItem, :count).by(1)

    expect(NewsItem.last.issue).to eq('Climate Change')
  end
end




end
