# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Display do
  subject(:form) { described_class.new(renderer, model) }

  let(:model)    { :my_model }
  let(:renderer) { instance_double('renderer') }
  let(:template) { 'templates/display/text' }
  let(:locals)   { {} }

  before do
    allow(renderer)
      .to receive(:render)
      .with(partial: template, locals: locals)
  end

  describe '.type' do
    it do
      expect(described_class.type).to eq(:display)
    end
  end

  describe '#input' do
    let(:template)    { 'templates/display/text' }
    let(:field)       { :field }
    let(:label)       { 'Label' }
    let(:placeholder) { 'Value' }

    let(:locals) do
      {
        field: field,
        label: label,
        ng_errors: 'my_model.errors.field',
        ng_model: 'my_model.field'
      }
    end

    let(:arguments) do
      {
        label: label,
        placeholder: placeholder
      }
    end

    it 'renders a text' do
      form.input(field, **arguments)

      expect(renderer).to have_received(:render)
    end

    context 'when passing a custom model' do
      let(:locals) do
        {
          field: field,
          label: label,
          ng_errors: 'my_custom_model.errors.field',
          ng_model: 'my_custom_model.field'
        }
      end

      it 'renders a text' do
        form.input(field, model: 'my_custom_model', **arguments)

        expect(renderer).to have_received(:render)
      end
    end
  end

  describe '#select' do
    let(:template)    { 'templates/display/text' }
    let(:field)       { :field }
    let(:label)       { 'Label' }
    let(:options)     { %i[option_a option_b] }

    let(:locals) do
      {
        field: field,
        label: label,
        ng_errors: 'my_model.errors.field',
        ng_model: 'my_model.field'
      }
    end

    let(:arguments) do
      {
        label: label,
        options: options
      }
    end

    it 'renders a text' do
      form.select(field, **arguments)

      expect(renderer).to have_received(:render)
    end

    context 'when passing a custom model' do
      let(:locals) do
        {
          field: field,
          label: label,
          ng_errors: 'my_custom_model.errors.field',
          ng_model: 'my_custom_model.field'
        }
      end

      it 'renders a text' do
        form.select(field, model: 'my_custom_model', **arguments)

        expect(renderer).to have_received(:render)
      end
    end
  end

  describe '#button' do
    let(:ng_click)    { 'controler.click()' }
    let(:ng_disabled) { 'false' }
    let(:classes)     { 'custom class' }
    let(:text)        { 'Click' }

    let(:arguments) do
      {
        ng_click: ng_click,
        ng_disabled: ng_disabled,
        classes: classes,
        text: text
      }
    end

    it 'renders nothing' do
      form.button(**arguments)

      expect(renderer).not_to have_received(:render)
    end
  end

  describe '#with_model' do
    let(:expected_form) { described_class.new(renderer, 'my_model.inner') }

    it do
      form.with_model(:inner) do |new_form|
        expect(new_form).to eq(expected_form)
      end
    end
  end

  describe '#with_form' do
    it do
      form.with_model('sub') do |new_form|
        expect(new_form)
          .to eq(described_class.new(renderer, 'my_model.sub'))
      end
    end

    context 'when passing a new base' do
      it do
        form.with_model('sub', base: :other_model) do |new_form|
          expect(new_form)
            .to eq(described_class.new(renderer, 'other_model.sub'))
        end
      end
    end

    context 'when passing an empty base' do
      it do
        form.with_model('sub', base: nil) do |new_form|
          expect(new_form)
            .to eq(described_class.new(renderer, 'sub'))
        end
      end
    end
  end

  describe '#only' do
    context 'when the type is included in the list' do
      it 'executes the block' do
        value = 0

        form.only(:not_included, :display, :other) { value += 1 }
        expect(value).to eq(1)
      end
    end

    context 'when the type is not included in the list' do
      it 'does not execute the block' do
        value = 0

        form.only(:not_included, :other) { value += 1 }
        expect(value).to be_zero
      end
    end
  end

  describe '#except' do
    context 'when the type is included in the list' do
      it 'does not execute the block' do
        value = 0

        form.except(:not_included, :display, :other) { value += 1 }
        expect(value).to be_zero
      end
    end

    context 'when the type is not included in the list' do
      it 'executes the block' do
        value = 0

        form.except(:not_included, :other) { value += 1 }
        expect(value).to eq(1)
      end
    end
  end
end
