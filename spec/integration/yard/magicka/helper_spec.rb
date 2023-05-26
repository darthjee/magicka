# frozen_string_literal: true

require 'spec_helper'

describe 'yard for Magicka::Helper' do
  describe '.with' do
    describe 'when passing only an aggregator' do
      let(:document) { create(:document) }

      let(:expected_body) do
        [
          '<dh>Name</dh>',
          "<dd>#{document.name}</dd><br />",
          '',
          '<dh>Reference</dh>',
          "<dd>#{document.reference}</dd>"
        ].join(" *\n *")
      end

      before { get "/documents/#{document.id}" }

      it do
        expect(response.status).to eq(200)
      end

      it do
        expect(response.body).to match(
          Regexp.new(expected_body)
        )
      end
    end
  end
end
