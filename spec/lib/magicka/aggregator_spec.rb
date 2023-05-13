# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Aggregator do
  subject(:aggregator) { aggregator_class.new(renderer, model) }

  let(:aggregator_class) { Class.new(described_class) }
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
        Class.new(described_class) do
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
    context 'when seeting element class only' do
      it do
        expect { aggregator_class.with_element(Magicka::Input) }
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
          aggregator_class.with_element(Magicka::Input)

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
        expect { aggregator_class.with_element(Magicka::Input, :my_input) }
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
          aggregator_class.with_element(Magicka::Input, :my_input)

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

    context 'when seeting element class and template' do
      it do
        expect do
          aggregator_class.with_element(Magicka::Input, template: template)
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
          aggregator_class.with_element(Magicka::Input, template: template)

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
  end

  describe '#with_model' do
    let(:expected_aggregator) do
      aggregator_class.new(renderer, 'my_model.inner')
    end

    it do
      aggregator.with_model(:inner) do |new_aggregator|
        expect(new_aggregator).to eq(expected_aggregator)
      end
    end
  end

  describe '#only' do
    let(:aggregator_class) do
      Class.new(described_class) do
        type :included
      end
    end

    context 'when the type is included in the list' do
      it 'executes the block' do
        value = 0

        aggregator.only(:not_included, :included, :other) { value += 1 }
        expect(value).to eq(1)
      end
    end

    context 'when the type is not included in the list' do
      it 'does not execute the block' do
        value = 0

        aggregator.only(:not_included, :other) { value += 1 }
        expect(value).to be_zero
      end
    end
  end

  describe '#except' do
    let(:aggregator_class) do
      Class.new(described_class) do
        type :included
      end
    end

    context 'when the type is included in the list' do
      it 'does not execute the block' do
        value = 0

        aggregator.except(:not_included, :included, :other) { value += 1 }
        expect(value).to be_zero
      end
    end

    context 'when the type is not included in the list' do
      it 'executes the block' do
        value = 0

        aggregator.except(:not_included, :other) { value += 1 }
        expect(value).to eq(1)
      end
    end
  end
end
