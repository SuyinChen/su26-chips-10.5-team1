# frozen_string_literal: true

require 'rails_helper'
require 'axe-rspec'

RSpec.describe 'Accessibility checks', :js, type: :feature do
  it 'has no accessibility violations on the homepage' do
    visit root_path

    expect(page).to be_axe_clean
  end

  it 'has no accessibility violations on a representative profile page' do
    representative = Representative.create!(name: 'Max Y', party: 'Democrat')
    visit representative_path(representative)

    expect(page).to be_axe_clean
  end
end
