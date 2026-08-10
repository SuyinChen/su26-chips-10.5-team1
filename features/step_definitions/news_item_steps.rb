# frozen_string_literal: true

Then('I should see {int} article choices') do |count|
  expect(page).to have_field(nil, type: 'radio', count: count)
end
