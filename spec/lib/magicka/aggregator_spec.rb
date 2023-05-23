# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Aggregator do
  subject(:aggregator) { aggregator_class.new(renderer, model) }

  let(:aggregator_class) { Class.new(described_class) }
  let(:model)            { :my_model }
  let(:renderer)         { instance_double('renderer') }
  let(:template)         { 'templates/forms/input' }
  let(:locals)           { {} }

  describe '#with_model' do
    let(:expected_aggregator) do
      aggregator_class.new(renderer, 'my_model.inner')
    end

    it do
      aggregator.with_model(:inner) do |new_aggregator|
        expect(new_aggregator).to eq(expected_aggregator)
      end
    end
  end

  describe '#only' do
    let(:aggregator_class) do
      Class.new(described_class) do
        type :included
      end
    end

    context 'when the type is included in the list' do
      it 'executes the block' do
        value = 0

        aggregator.only(:not_included, :included, :other) { value += 1 }
        expect(value).to eq(1)
      end
    end

    context 'when the type is not included in the list' do
      it 'does not execute the block' do
        value = 0

        aggregator.only(:not_included, :other) { value += 1 }
        expect(value).to be_zero
      end
    end
  end

  describe '#except' do
    let(:aggregator_class) do
      Class.new(described_class) do
        type :included
      end
    end

    context 'when the type is included in the list' do
      it 'does not execute the block' do
        value = 0

        aggregator.except(:not_included, :included, :other) { value += 1 }
        expect(value).to be_zero
      end
    end

    context 'when the type is not included in the list' do
      it 'executes the block' do
        value = 0

        aggregator.except(:not_included, :other) { value += 1 }
        expect(value).to eq(1)
      end
    end
  end
end
