# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepresentativesController do
  describe 'GET #show' do
    it 'assigns the requested representative' do
      rep = Representative.create!(name: 'Max Yfantopoulos', party: 'Democrat')
      get :show, params: { id: rep.id }
      expect(response).to be_successful
      expect(assigns(:representative)).to eq(rep)
    end
  end
end
