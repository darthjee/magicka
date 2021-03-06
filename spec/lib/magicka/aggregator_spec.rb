# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Aggregator do
  subject(:aggregator) { aggregator_class.new(renderer, model) }

  let(:aggregator_class) { Class.new(described_class) }
  let(:model)            { :my_model }
  let(:renderer)         { instance_double('renderer') }
  let(:template)         { 'templates/forms/input' }
  let(:locals)           { {} }

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
          aggregator.input(field, arguments)

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
          aggregator.my_input(field, arguments)

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
          aggregator.input(field, arguments)

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
end
