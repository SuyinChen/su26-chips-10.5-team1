# frozen_string_literal: true

# == Schema Information
#
# Table name: representatives
#
#  id         :integer          not null, primary key
#  city       :string
#  name       :string
#  ocdid      :string
#  party      :string
#  photo_url  :string
#  state      :string
#  street     :string
#  title      :string
#  zip        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
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
    end
  end
end
