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
  let(:config_block) do
    proc { with_element(Magicka::Input) }
  end

  describe '#configured_aggregator_class' do
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

    context 'when aggregator_class is a class' do
      context 'when config block is given' do
        it 'returns the given aggregator class' do
          expect(options.configured_aggregator_class)
            .to be(aggregator_class)
        end

        it 'configure the aggregator' do
          options.configured_aggregator_class.new(renderer, model)
            .input(:name)

          expect(element_class).to have_received(:render)
        end
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
