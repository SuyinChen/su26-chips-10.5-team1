# frozen_string_literal: true

# == Schema Information
#
# Table name: representatives
#
#  id           :integer          not null, primary key
#  address      :string
#  birthday     :date
#  contact_form :string
#  facebook     :string
#  gender       :string
#  name         :string
#  ocdid        :string
#  party        :string
#  phone        :string
#  title        :string
#  twitter      :string
#  website      :string
#  youtube      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  bioguide_id  :string
#
require 'rails_helper'

# This file is a stub.
# You should add your own test cases.
# We recommend creating a file for each model in the database.

RSpec.describe Representative do
  describe '.find_rep' do
    before do
      @official = {
        'name' => 'Jane Doe'
      }

      described_class.create!(
        name: 'Jane Doe',
        ocdid: '412345',
        title: 'representative'
      )
    end

    it 'avoids creating duplicate records' do
      described_class.find_rep(@official, ocdid: '412345', title: 'representative')

      expect(described_class.count).to eq(1)
      expect do
        described_class.find_rep(@official, ocdid: '412345', title: 'representative')
      end.not_to change(described_class, :count)
    end
  end

  describe '.civic_api_to_representative_params' do
    before do
      stub_request(:post, /api\.geocod\.io/).to_return(
        status: 200,
        body: Rails.root.join('spec/fixtures/geocodio_response.json').read,
        headers: { 'Content-Type' => 'application/json' }
      )
      @rep = described_class.civic_api_to_representative_params(
        described_class.geocodio_search('123 Main St')
      ).first
    end

    it 'stores the party from the bio block' do
      expect(@rep.party).to eq('Democrat')
    end

    it 'stores contact details' do
      expect(@rep.phone).to eq('202-225-0000')
      expect(@rep.website).to eq('https://doe.house.gov')
    end

    it 'stores the bioguide id from the references block' do
      expect(@rep.bioguide_id).to eq('D000000')
    end
  end
end
