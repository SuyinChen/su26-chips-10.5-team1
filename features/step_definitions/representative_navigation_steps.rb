# frozen_string_literal: true

When('I search for representatives at {string}') do |address|
  visit search_representatives_path(address: address)
end

Then('I should see a profile link for {string}') do |name|
  representative = Representative.find_by!(name: name)
  expect(page).to have_link(name, href: representative_path(representative))
end

When('I follow the profile link for {string}') do |name|
  representative = Representative.find_by!(name: name)
  find_link(name, href: representative_path(representative)).click
end

Then('I should arrive at the profile page for {string}') do |name|
  representative = Representative.find_by!(name: name)
  expect(page).to have_current_path(representative_path(representative))
  expect(page).to have_css('h1', text: name)
end

Given('a news item titled {string} exists for {string}') do |title, representative_name|
  representative = Representative.find_by!(name: representative_name)

  NewsItem.create!(
    title: title,
    link: 'https://example.com/news',
    description: 'A test news article',
    representative: representative
  )
end

When('I visit the news list for {string}') do |name|
  representative = Representative.find_by!(name: name)
  visit representative_news_items_path(representative)
end

When('I visit the news item {string} for {string}') do |title, representative_name|
  representative = Representative.find_by!(name: representative_name)
  news_item = representative.news_items.find_by!(title: title)

  visit representative_news_item_path(representative, news_item)
end
