# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Aggregator::MethodBuilder do
  subject(:builder) do
    aggregator_class.new(aggregator_class, element_class_arg)
  end

  let(:aggregator_class)  { Class.new(described_class) }
  let(:element_class_arg) { element_class }
  let(:element_class)     { Magicka::MyElement }

  describe '#element_class' do
    context 'when passing an element class' do
      it do
        expect(builder.element_class).to eq(element_class)
      end
    end

    context 'when passing an element class name' do
      let(:element_class_arg) { element_class.to_s }

      it do
        expect(builder.element_class).to eq(element_class)
      end
    end
  end
end
