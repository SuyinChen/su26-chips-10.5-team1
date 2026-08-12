# frozen_string_literal: true

# == Schema Information
#
# Table name: news_items
#
#  id                :integer          not null, primary key
#  average_rating    :decimal(3, 2)
#  description       :text
#  issue             :string
#  link              :string           not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  representative_id :integer          not null
#
# Indexes
#
#  index_news_items_on_representative_id  (representative_id)
#
require 'rails_helper'

RSpec.describe NewsItem do
  before do
    @representative = Representative.create!(
      name: 'Jane Doe', ocdid: '412345', title: 'representative'
    )
    @news_item = described_class.create!(
      title: 'A headline',
      link: 'https://example.com',
      representative: @representative
    )
    @alice = User.create!(provider: :github, uid: '1')
    @bob = User.create!(provider: :github, uid: '2')
  end

  it 'has no average rating before anyone rates it' do
    expect(@news_item.average_rating).to be_nil
  end

  it 'reflects a single rating' do
    Rating.create!(value: 4, user: @alice, news_item: @news_item)
    expect(@news_item.reload.average_rating).to eq(4)
  end

  it 'averages multiple ratings' do
    Rating.create!(value: 4, user: @alice, news_item: @news_item)
    Rating.create!(value: 3, user: @bob, news_item: @news_item)
    expect(@news_item.reload.average_rating).to eq(3.5)
  end

  it 'recomputes when a rating is removed' do
    Rating.create!(value: 4, user: @alice, news_item: @news_item)
    rating = Rating.create!(value: 2, user: @bob, news_item: @news_item)
    rating.destroy
    expect(@news_item.reload.average_rating).to eq(4)
  end
end
