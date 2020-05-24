# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Element do
  subject(:element) { klass.new(renderer: renderer) }

  let(:klass) do
    Class.new(described_class)
  end

  let(:renderer) { instance_double('renderer') }
  let(:template) { 'templates/forms/element' }
  let(:locals)   { {} }

  describe '#render' do
    before do
      klass.template(template)

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

    context 'when class have locals defined' do
      subject(:element) do
        klass.new(renderer: renderer, name: 'Name')
      end

      let(:locals) { { name: 'Name' } }

      before do
        klass.send(:with_attribute_locals, :name)
      end

      it do
        element.render

        expect(renderer).to have_received(:render)
      end
    end
  end
end
