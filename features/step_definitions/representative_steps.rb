# frozen_string_literal: true

Given /^the following representatives exist:$/ do |table|
  table.hashes.each { |row| Representative.create!(row)}
end

When /^I visit the profile page for "([^"]*)"$/ do |name|
  visit representative_path(Representative.find_by(name: name))
end