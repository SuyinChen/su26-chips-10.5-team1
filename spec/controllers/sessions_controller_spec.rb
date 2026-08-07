# frozen_string_literal: true

require 'rails_helper'

describe SessionsController do
  describe 'GET #new' do
    let!(:user) do
      User.create!(
        first_name: 'Test',
        last_name: 'User',
        provider: :developer,
        uid: '12345'
      )
    end

    it 'renders the login page' do
      get :new

      expect(response).to be_successful
    end

    it 'redirects logged in users' do
      # user = User.create!(
      #   first_name: 'Test',
      #   last_name: 'User',
      #   provider: :developer,
      #   uid: '12345'
      # )

      session[:user_id] = user.id

      get :new

      expect(response).to be_redirect
    end
  end

  describe 'POST #create' do
    let(:omniauth_data) do
      {
        'provider' => 'developer',
        'uid' => '12347',
        'info' => {
          'first_name' => 'Test',
          'last_name' => 'User'
        }
      }
    end

    it 'logs in a developer user' do
      allow(Rails.env).to receive(:development?).and_return(true)
      request.env['omniauth.auth'] = omniauth_data
      post :create, params: { provider: 'developer' }
      expect(session[:user_id]).to be_present
    end
  end
end
