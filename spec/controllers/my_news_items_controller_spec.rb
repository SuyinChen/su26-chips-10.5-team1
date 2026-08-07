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
end
