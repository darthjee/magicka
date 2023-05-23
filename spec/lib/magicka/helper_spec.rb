# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Helper do
  subject(:object) { klass.new }

  let(:klass) do
    Class.new do
      include Magicka::Helper
    end
  end

  let(:model) { 'model' }

  describe '.with' do
    let(:aggregator_class) do
      Class.new(Magicka::Aggregator) do
        def self.name
          'Magicka::MyClass'
        end
      end
    end

    context 'when passing a class' do
      it do
        expect { described_class.with(aggregator_class) }
          .to add_method('magicka_my_class')
          .to(object)
      end
    end

    context 'when passing a string as agregator' do
      let(:aggregator_name) { :Test1Aggregator }
      let(:aggregator_class_name) { "Magicka::#{aggregator_name}" }

      it do
        expect { described_class.with(aggregator_class_name, :test1_aggregator) }
          .to add_method('magicka_test1_aggregator')
          .to(object)
      end
    end
  end

  describe '#magicka_display' do
    it do
      object.magicka_display(model) do |display|
        expect(display).to be_a(Magicka::Display)
      end
    end

    it 'populates the model' do
      object.magicka_display(model) do |display|
        expect(display.model).to eq(model)
      end
    end

    it 'populates the renderer' do
      object.magicka_display(model) do |display|
        expect(display.send(:renderer)).to eq(object)
      end
    end
  end

  describe '#magicka_form' do
    it do
      object.magicka_form(model) do |form|
        expect(form).to be_a(Magicka::Form)
      end
    end

    it 'populates the model' do
      object.magicka_form(model) do |form|
        expect(form.model).to eq(model)
      end
    end

    it 'populates the renderer' do
      object.magicka_form(model) do |form|
        expect(form.send(:renderer)).to eq(object)
      end
    end
  end
end
