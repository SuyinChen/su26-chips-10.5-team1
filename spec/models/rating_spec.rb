# frozen_string_literal: true

# == Schema Information
#
# Table name: ratings
#
#  id           :integer          not null, primary key
#  value        :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  news_item_id :integer          not null
#  user_id      :integer          not null
#
# Indexes
#
#  index_ratings_on_news_item_id              (news_item_id)
#  index_ratings_on_user_id                   (user_id)
#  index_ratings_on_user_id_and_news_item_id  (user_id,news_item_id) UNIQUE
#
# Foreign Keys
#
#  news_item_id  (news_item_id => news_items.id)
#  user_id       (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Rating do
  before do
    @representative = Representative.create!(
      name: 'Jane Doe', ocdid: '412345', title: 'representative'
    )
    @user = User.create!(provider: :github, uid: '12345')
    @news_item = NewsItem.create!(
      title: 'A headline',
      link: 'https://example.com',
      representative: @representative
    )
  end

  it 'is invalid with a value outside 1..5' do
    rating = described_class.new(value: 6, user: @user, news_item: @news_item)
    expect(rating).not_to be_valid
  end

  it 'prevents a user from rating the same article twice' do
    described_class.create!(value: 4, user: @user, news_item: @news_item)
    duplicate = described_class.new(value: 2, user: @user, news_item: @news_item)
    expect(duplicate).not_to be_valid
  end
end
