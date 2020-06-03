# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Form do
  subject(:form) { described_class.new(renderer, model) }

  let(:model)    { :my_model }
  let(:renderer) { instance_double('renderer') }

  before do
    allow(renderer)
      .to receive(:render)
      .with(partial: template, locals: locals)
  end

  describe '#input' do
    let(:template)    { 'templates/forms/input' }
    let(:field)       { :field }
    let(:label)       { 'Label' }
    let(:placeholder) { 'Value' }

    let(:locals) do
      {
        field: field,
        label: label,
        ng_errors: 'my_model.errors.field',
        ng_model: 'my_model.field',
        placeholder: placeholder
      }
    end

    let(:arguments) do
      {
        label: label,
        placeholder: placeholder,
        model: model
      }
    end

    it 'renders an input' do
      form.input(field, arguments)

      expect(renderer).to have_received(:render)
    end
  end
end
