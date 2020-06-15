# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Element do
  subject(:element) { klass.new(renderer: renderer) }

  let(:klass) do
    Class.new(described_class)
  end

  let(:renderer) { instance_double('renderer') }
  let(:template) { 'templates/forms/element' }
  let(:folder)   { 'templates/forms' }
  let(:locals)   { {} }

  let(:method_builder)    { Sinclair.new(klass) }
  let(:expected_template) { template }

  describe '#render' do
    before do
      allow(renderer)
        .to receive(:render)
        .with(partial: expected_template, locals: locals)
    end

    context 'when class has a defined template' do
      before do
        klass.template(template)
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

    context 'when class has only folder defined' do
      let(:expected_template) { 'templates/forms/my_element' }

      before do
        klass.template_folder(folder)

        method_builder.add_class_method(:name) { 'Magicka::MyElement' }
        method_builder.build
      end

      it do
        element.render

        expect(renderer).to have_received(:render)
      end
    end

    context 'when class has a template defined but instance is initialized with template' do
      subject(:element) { klass.new(renderer: renderer, template: custom_template) }

      let(:custom_template) { 'custom_folder/custom_template' }
      let(:expected_template) { custom_template }

      before do
        klass.template(template)
      end

      it do
        element.render

        expect(renderer).to have_received(:render)
      end
    end

    context 'when class has folder defined but instance is initialized with template' do
      subject(:element) { klass.new(renderer: renderer, template: custom_template) }

      let(:custom_template)   { 'custom_folder/custom_template' }
      let(:expected_template) { custom_template }

      before do
        klass.template_folder(folder)

        method_builder.add_class_method(:name) { 'Magicka::MyElement' }
        method_builder.build
      end

      it do
        element.render

        expect(renderer).to have_received(:render)
      end
    end
  end
end
