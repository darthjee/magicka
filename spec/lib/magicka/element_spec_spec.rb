# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Element do
  subject(:element) { klass.new(renderer: renderer) }

  let(:klass) do
    Class.new(described_class)
  end

  let(:renderer) { double('renderer') }
  let(:template) { 'templates/forms/element' }
  let(:locals)   { {} }

  describe '.template' do
    it do
      expect { klass.send(:template, template) }
        .to add_method(:template)
        .to(klass)
    end

    context 'when method is build as requested' do
      before { klass.send(:template, template) }

      it 'returns the defined template when method is called' do
        expect(element.template).to eq(template)
      end
    end
  end

  describe '.render' do
    before do
      klass.send(:template, template)

      allow(renderer)
        .to receive(:render)
        .with(partial: template, locals: locals)
    end

    it do
      klass.render(renderer: renderer)

      expect(renderer).to have_received(:render)
    end

    context 'when called with extra params' do
      it do
        klass.render(renderer: renderer, name: 'Name')

        expect(renderer).to have_received(:render)
      end
    end
  end

  describe '#render' do
    before do
      klass.send(:template, template)

      allow(renderer)
        .to receive(:render)
        .with(partial: template, locals: locals)
    end

    it do
      element.render

      expect(renderer).to have_received(:render)
    end

    context 'when initialized with extra params' do
      subject(:element) do
        klass.new(renderer: renderer, name: 'Name')
      end

      it do
        element.render

        expect(renderer).to have_received(:render)
      end
    end
  end
end
