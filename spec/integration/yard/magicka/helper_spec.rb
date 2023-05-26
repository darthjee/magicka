# frozen_string_literal: true

require 'spec_helper'

describe 'yard for Magicka::Helper' do
  describe '.with' do
    describe 'when passing only an aggregator' do
      it do
        get '/documents/1'

        expect(response.status).to eq(200)
      end
    end
  end
end
