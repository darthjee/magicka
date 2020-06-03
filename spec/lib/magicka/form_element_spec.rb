# frozen_string_literal: true

require 'spec_helper'

describe Magicka::FormElement do
  let(:renderer) { instance_double('renderer') }
  let(:template) { 'templates/forms/custom_template' }

  let(:expected_template) { template }

  let(:model) { :my_model }
  let(:field) { :field }
  let(:label) { 'Label' }
  let(:klass) { Class.new(described_class) }

  let(:locals) do
    {
      field: field,
      label: label,
      ng_errors: 'my_model.errors.field',
      ng_model: 'my_model.field'
    }
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
        .with(partial: expected_template, locals: locals)
    end

    context 'when defined template' do
      before do
        klass.template(template)
      end

      it do
        klass.render(arguments)

        expect(renderer).to have_received(:render)
      end

      context 'when called with extra params' do
        it do
          klass.render(name: 'Name', **arguments)

          expect(renderer).to have_received(:render)
        end
      end
    end

    context 'when not defining a template' do
      let(:method_builder)    { Sinclair.new(klass) }
      let(:expected_template) { 'templates/forms/my_custom_element' }

      before do
        method_builder.add_class_method(:name) do
          'Magicka::MyCustomElement'
        end
        method_builder.build
      end

      it do
        klass.render(arguments)

        expect(renderer).to have_received(:render)
      end

      context 'when called with extra params' do
        it do
          klass.render(name: 'Name', **arguments)

          expect(renderer).to have_received(:render)
        end
      end
    end
  end
end
