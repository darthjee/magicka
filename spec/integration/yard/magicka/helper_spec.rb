# frozen_string_literal: true

require 'spec_helper'

describe 'yard for Magicka::Helper' do
  describe '.with' do
    describe 'when passing only an aggregator' do
      let(:document) { create(:document) }

      before { get "/documents/#{document.id}" }

      it do
        expect(response.status).to eq(200)
      end
    end
  end
end
