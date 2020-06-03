# frozen_string_literal: true

require 'spec_helper'

describe Magicka::FormElement do
  let(:renderer) { instance_double('renderer') }
  let(:template) { 'templates/forms/input' }

  let(:model)       { :my_model }
  let(:field)       { :field }
  let(:label)       { 'Label' }

  let(:locals) do
    {
      field: field,
      label: label,
      ng_errors: 'my_model.errors.field',
      ng_model: 'my_model.field'
    }
  end

  before do
    described_class.template(template)
  end

  describe '.render' do
    let(:arguments) do
      {
        renderer: renderer,
        field: field,
        label: label,
        model: model
      }
    end

    before do
      allow(renderer)
        .to receive(:render)
        .with(partial: template, locals: locals)
    end

    it do
      described_class.render(arguments)

      expect(renderer).to have_received(:render)
    end

    context 'when called with extra params' do
      it do
        described_class.render(name: 'Name', **arguments)

        expect(renderer).to have_received(:render)
      end
    end
  end
end
