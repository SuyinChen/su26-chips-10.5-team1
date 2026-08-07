# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController do
  before do
    allow(controller).to receive(:require_login!)

    @california = State.create!(
      name: 'California', symbol: 'CA', fips_code: 6,
      is_territory: 0, lat_min: 32.30, lat_max: 40.00,
      long_min: 114.8, long_max: 124.24
    )
    @san_francisco = @california.counties.create!(
      name: 'San Francisco', fips_code: 75, fips_class: 'CA'
    )

    @event = Event.create!(
      name: 'Guangzhou Food Night', county: @san_francisco,
      start_time: 2.days.from_now, end_time: 3.days.from_now
    )

    @valid_event = {
      name: 'Brotato Tournament',
      county_id: @san_francisco.id,
      start_time: 4.days.from_now,
      end_time: 5.days.from_now
    }
    @invalid_event = {
      name: 'Impossible Game Night',
      county_id: @san_francisco.id
    }
    @update_params = {
      id: @event.id,
      event: { name: 'Berkeley CS169A Meetup' }
    }
    @invalid_update_params = {
      id: @event.id,
      event: { start_time: nil }
    }
  end

  describe 'GET #new' do
    it 'creates a new event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    it 'loads the selected event' do
      get :edit, params: { id: @event.id }
      expect(assigns(:event)).to eq(@event)
    end
  end

  describe 'POST #create' do
    it 'creates an event with valid information' do
      expect { post :create, params: { event: @valid_event } }.to change(Event, :count).by(1)
      expect(response).to redirect_to(events_path)
    end

    it 'does not create an invalid event' do
      post :create, params: { event: @invalid_event }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH #update' do
    it 'updates an event with valid information' do
      patch :update, params: @update_params
      expect(@event.reload.name).to eq('Berkeley CS169A Meetup')
      expect(response).to redirect_to(events_path)
    end

    it 'does not update an event with invalid information' do
      patch :update, params: @invalid_update_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the event' do
      expect { delete :destroy, params: { id: @event.id } }.to change(Event, :count).by(-1)
      expect(response).to redirect_to(events_url)
    end
  end
end
