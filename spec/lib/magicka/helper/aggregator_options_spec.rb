# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Helper::AggregatorOptions do
  subject(:options) { described_class.new(options_hash) }

  let(:options_hash) do
    {
      aggregator: aggregator,
      type: type,
      config_block: config_block
    }
  end

  let(:aggregator_class) { Class.new(Magicka::Aggregator) }
  let(:aggregator)       { aggregator_class }
  let(:type)             { :my_aggregator }
  let(:config_block) do
    proc { with_element(Magicka::Input) }
  end

  describe '#configured_aggregator' do
    let(:renderer)       { instance_double(ActionView::OutputBuffer) }
    let(:model)          { Object.new }
    let(:element_class)  { Magicka::Input }

    before do
      allow(element_class).to receive(:render).with(
        renderer: renderer,
        field: :name,
        model: model,
        template: nil
      )
    end

    context 'when aggregator is a class' do
      context 'when config block is given' do
        it 'returns the given aggregator class' do
          expect(options.configured_aggregator)
            .to be(aggregator)
        end

        it 'configure the aggregator' do
          options.configured_aggregator.new(renderer, model)
            .input(:name)

          expect(element_class).to have_received(:render)
        end
      end

      context 'when config block is not given' do
        let(:config_block) { nil }

        it 'returns the given aggregator class' do
          expect(options.configured_aggregator)
            .to be(aggregator)
        end
      end
    end

    context 'when aggregator is a String' do
      let(:aggregator)      { "Magicka::#{aggregator_name}" }
      let(:aggregator_name) { :CustomAggregator }

      before { Magicka.const_set(aggregator_name, aggregator_class) }

      context 'when config block is given' do
        let(:aggregator_name) { :CustomAggregator1 }

        it 'returns the given aggregator class' do
          expect(options.configured_aggregator)
            .to be(aggregator_class)
        end
      end

      context 'when config block is given and is called' do
        let(:aggregator_name) { :CustomAggregator2 }

        it 'configure the aggregator' do
          options.configured_aggregator.new(renderer, model)
            .input(:name)

          expect(element_class).to have_received(:render)
        end
      end

      context 'when config block is not given' do
        let(:aggregator_name) { :CustomAggregator3 }
        let(:config_block) { nil }

        it 'returns the given aggregator class' do
          expect(options.configured_aggregator)
            .to be(aggregator_class)
        end
      end
    end
  end
end
