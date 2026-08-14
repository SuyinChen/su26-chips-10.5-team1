# frozen_string_literal: true

When('I rate the article {int}') do |value|
  select value.to_s, from: 'Rating'
  click_button 'Rate'
end

Then('I should see an average rating of {string}') do |average|
  expect(page).to have_content('Average rating:')
  expect(page).to have_content(average)
end
