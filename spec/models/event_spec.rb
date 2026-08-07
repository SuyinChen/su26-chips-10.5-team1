# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event do
  before do
    @california = State.create!(
      name: 'California', symbol: 'CA', fips_code: 6,
      is_territory: 0, lat_min: 32.30, lat_max: 40.00,
      long_min: 114.8, long_max: 124.24
    )
    @san_francisco = @california.counties.create!(
      name: 'San Francisco', fips_code: 75, fips_class: 'CA'
    )
    @santa_clara = @california.counties.create!(
      name: 'Santa Clara', fips_code: 85, fips_class: 'CA'
    )

    @event = described_class.new(
      name: 'Guangzhou Summer Festival',
      county: @san_francisco,
      start_time: 2.days.from_now,
      end_time: 3.days.from_now
    )

    @county_names = {
      'San Francisco' => @san_francisco.id,
      'Santa Clara' => @santa_clara.id
    }
  end

  it 'is valid with future start and end times' do
    expect(@event).to be_valid
  end

  it 'requires start and end times' do
    @event.start_time = nil
    @event.end_time = nil
    expect(@event).not_to be_valid
  end

  it 'does not allow a start time in the past' do
    @event.name = 'Expired Brotato Tournament'
    @event.start_time = 2.days.ago
    expect(@event).not_to be_valid
  end

  it 'does not allow the end time before the start time' do
    @event.name = 'Impossible Game Night'
    @event.end_time = 1.day.from_now
    expect(@event).not_to be_valid
  end

  it 'gets the state from its county' do
    expect(@event.state).to eq(@california)
  end

  it 'returns counties from the same state' do
    expect(@event.county_names_by_id).to eq(@county_names)
  end
end
