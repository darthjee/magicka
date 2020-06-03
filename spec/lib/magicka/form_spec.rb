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

  describe '#select' do
    let(:template)    { 'templates/forms/select' }
    let(:field)       { :field }
    let(:label)       { 'Label' }
    let(:options)     { %i[option_a option_b] }

    let(:locals) do
      {
        field: field,
        label: label,
        ng_errors: 'my_model.errors.field',
        ng_model: 'my_model.field',
        options: options
      }
    end

    let(:arguments) do
      {
        label: label,
        model: model,
        options: options
      }
    end

    it 'renders an input' do
      form.select(field, arguments)

      expect(renderer).to have_received(:render)
    end
  end

  describe '#button' do
    let(:template)    { 'templates/forms/button' }
    let(:ng_click)    { 'controler.click()' }
    let(:ng_disabled) { 'false' }
    let(:classes)     { 'custom class' }
    let(:text)        { 'Click' }

    let(:locals) do
      {
        ng_click: ng_click,
        ng_disabled: ng_disabled,
        classes: classes,
        text: text
      }
    end

    let(:arguments) do
      {
        ng_click: ng_click,
        ng_disabled: ng_disabled,
        classes: classes,
        text: text
      }
    end

    it 'renders an input' do
      form.button(arguments)

      expect(renderer).to have_received(:render)
    end
  end
end
