# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Helper::AggregatorOptions do
  subject(:options) { described_class.new(options_hash) }

  let(:options_hash) do
    {
      aggregator_class: aggregator_class,
      type: type,
      config_block: config_block
    }
  end

  let(:aggregator_class) { Class.new(Magicka::Aggregator) }
  let(:type)             { :my_aggregator }
  let(:config_block)     { proc { } }

  describe '#configured_aggregator_class' do
    context 'when aggregator_class is a class' do
      it 'returns the given aggregator class' do
        expect(options.configured_aggregator_class)
          .to be(aggregator_class)
      end

      context 'when config block is not given' do
        let(:config_block) { nil }

        it 'returns the given aggregator class' do
          expect(options.configured_aggregator_class)
            .to be(aggregator_class)
        end
      end
    end
  end
end
