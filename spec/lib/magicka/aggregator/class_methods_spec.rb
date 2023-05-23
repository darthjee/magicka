# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Aggregator::ClassMethods do
  subject(:aggregator) { aggregator_class.new(renderer, model) }

  let(:aggregator_class) { Class.new(Magicka::Aggregator) }
  let(:model)            { :my_model }
  let(:renderer)         { instance_double('renderer') }
  let(:template)         { 'templates/forms/input' }
  let(:locals)           { {} }

  describe '.type' do
    let(:type) { %w[form display other].sample }

    it 'sets aggregator type' do
      expect { aggregator_class.type(type) }
        .to change(aggregator_class, :type)
        .from(nil).to(type.to_sym)
    end

    context 'when type has not been set' do
      let(:aggregator_class) do
        Class.new(Magicka::Aggregator) do
          def self.name
            'Magicka::MyClass'
          end
        end
      end

      it 'Uses class name as type' do
        expect(aggregator_class.type)
          .to eq(:my_class)
      end
    end
  end

  describe '.with_element' do
    let(:element_class) { Magicka::Input }

    context 'when seeting element class only' do
      it do
        expect { aggregator_class.with_element(element_class) }
          .to add_method(:input)
          .to(aggregator)
      end

      context 'when built method is called' do
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
            placeholder: placeholder
          }
        end

        before do
          aggregator_class.with_element(element_class)

          allow(renderer)
            .to receive(:render)
            .with(partial: template, locals: locals)
        end

        it 'renders an input' do
          aggregator.input(field, **arguments)

          expect(renderer).to have_received(:render)
        end

        context 'when passing a custom model' do
          let(:locals) do
            {
              field: field,
              label: label,
              ng_errors: 'my_custom_model.errors.field',
              ng_model: 'my_custom_model.field',
              placeholder: placeholder
            }
          end

          it 'renders an input' do
            aggregator.input(field, model: 'my_custom_model', **arguments)

            expect(renderer).to have_received(:render)
          end
        end
      end
    end

    context 'when seeting element class and method' do
      it do
        expect { aggregator_class.with_element(element_class, :my_input) }
          .to add_method(:my_input)
          .to(aggregator)
      end

      context 'when built method is called' do
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
            placeholder: placeholder
          }
        end

        before do
          aggregator_class.with_element(element_class, :my_input)

          allow(renderer)
            .to receive(:render)
            .with(partial: template, locals: locals)
        end

        it 'renders an input' do
          aggregator.my_input(field, **arguments)

          expect(renderer).to have_received(:render)
        end

        context 'when passing a custom model' do
          let(:locals) do
            {
              field: field,
              label: label,
              ng_errors: 'my_custom_model.errors.field',
              ng_model: 'my_custom_model.field',
              placeholder: placeholder
            }
          end

          it 'renders an input' do
            aggregator.my_input(field, model: 'my_custom_model', **arguments)

            expect(renderer).to have_received(:render)
          end
        end
      end
    end

    context 'when setting element class and template' do
      it do
        expect do
          aggregator_class.with_element(element_class, template: template)
        end
          .to add_method(:input)
          .to(aggregator)
      end

      context 'when built method is called' do
        let(:template)    { 'my_templates/my_input' }
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
            placeholder: placeholder
          }
        end

        before do
          aggregator_class.with_element(element_class, template: template)

          allow(renderer)
            .to receive(:render)
            .with(partial: template, locals: locals)
        end

        it 'renders an input' do
          aggregator.input(field, **arguments)

          expect(renderer).to have_received(:render)
        end

        context 'when passing a custom model' do
          let(:locals) do
            {
              field: field,
              label: label,
              ng_errors: 'my_custom_model.errors.field',
              ng_model: 'my_custom_model.field',
              placeholder: placeholder
            }
          end

          it 'renders an input' do
            aggregator.input(field, model: 'my_custom_model', **arguments)

            expect(renderer).to have_received(:render)
          end
        end
      end
    end

    context 'when element class is defined with a string' do
      let(:element_class) { 'Magicka::Input' }

      it do
        expect { aggregator_class.with_element(element_class) }
          .to add_method(:input)
          .to(aggregator)
      end

      context 'when built method is called' do
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
            placeholder: placeholder
          }
        end

        before do
          aggregator_class.with_element(element_class)

          allow(renderer)
            .to receive(:render)
            .with(partial: template, locals: locals)
        end

        it 'renders an input' do
          aggregator.input(field, **arguments)

          expect(renderer).to have_received(:render)
        end

        context 'when passing a custom model' do
          let(:locals) do
            {
              field: field,
              label: label,
              ng_errors: 'my_custom_model.errors.field',
              ng_model: 'my_custom_model.field',
              placeholder: placeholder
            }
          end

          it 'renders an input' do
            aggregator.input(field, model: 'my_custom_model', **arguments)

            expect(renderer).to have_received(:render)
          end
        end
      end
    end

    context 'when element class is defined with a string and the element loaded later' do
      let(:element_class) { 'Magicka::SpecDefinedInput' }

      it do
        expect { aggregator_class.with_element(element_class, :input) }
          .to add_method(:input)
          .to(aggregator)
      end

      context 'when built method is called' do
        let(:template)    { 'templates/forms/my_input' }
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
            placeholder: placeholder
          }
        end

        before do
          aggregator_class.with_element(element_class, :input, template: template)

          Magicka.const_set(:SpecDefinedInput, Class.new(Magicka::Input))

          allow(renderer)
            .to receive(:render)
            .with(partial: template, locals: locals)
        end

        it 'renders an input' do
          aggregator.input(field, **arguments)

          expect(renderer).to have_received(:render)
        end
      end
    end
  end
end
