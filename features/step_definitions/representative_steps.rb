# frozen_string_literal: true

Given /^the following representatives exist:$/ do |table|
  table.hashes.each { |row| Representative.create!(row) }
end

When /^I visit the profile page for "([^"]*)"$/ do |name|
  visit representative_path(Representative.find_by(name: name))
end

Then('I should see a link {string} to {string}') do |link_text, href|
  expect(page).to have_link(link_text, href: href)
end

Then('I should see a portrait for {string}') do |name|
  representative = Representative.find_by!(name: name)
  portrait_url =
    'https://bioguide.congress.gov/bioguide/photo/' \
    "#{representative.bioguide_id.first}/#{representative.bioguide_id}.jpg"

  expect(page).to have_css(
    "img[alt='Portrait of #{name}'][src='#{portrait_url}']"
  )
end
