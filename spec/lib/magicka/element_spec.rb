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

  describe '.with_attributes' do
    it do
      expect { klass.send(:with_attributes, :field) }
        .to add_method(:field)
        .to(klass)
    end
  end

  describe '.template' do
    it do
      expect { klass.send(:template, template) }
        .to add_method(:template)
        .to(klass)
    end

    context 'when method is build as requested' do
      before { klass.send(:template, template) }

      it 'returns the defined template when method is called' do
        expect(element.template).to eq(template)
      end
    end
  end

  describe '.render' do
    before do
      klass.send(:template, template)

      allow(renderer)
        .to receive(:render)
        .with(partial: template, locals: locals)
    end

    it do
      klass.render(renderer: renderer)

      expect(renderer).to have_received(:render)
    end

    context 'when called with extra params' do
      it do
        klass.render(renderer: renderer, name: 'Name')

        expect(renderer).to have_received(:render)
      end
    end
  end

  describe '.locals' do
    it { expect(described_class.locals).to eq(Set.new([])) }

    context 'when calling on a subclass' do
      it { expect(klass.locals).to eq(Set.new([])) }
    end

    context 'when called on subclass' do
      let(:subclass) { Class.new(klass) }

      before { klass.send(:with_locals, :field, :model) }

      it { expect(subclass.locals).to eq(Set.new(%i[field model])) }
    end
  end

  describe 'with_locals' do
    it do
      expect { klass.send(:with_locals, :field, :model) }
        .to change(klass, :locals)
        .from([])
        .to(%i[field model])
    end

    it do
      expect { klass.send(:with_locals, :field, :model) }
        .not_to change(described_class, :locals)
    end

    it do
      expect { klass.send(:with_locals, :field) }
        .not_to add_method(:field)
        .to(klass)
    end

    context 'when called on subclass' do
      let(:subclass) { Class.new(klass) }

      before { klass.send(:with_locals, :field, :model) }

      it do
        expect { subclass.send(:with_locals, :error) }
          .to change(subclass, :locals)
          .from(%i[field model])
          .to(%i[field model error])
      end

      it do
        expect { subclass.send(:with_locals, :error) }
          .not_to change(klass, :locals)
      end
    end
  end

  describe '#render' do
    before do
      klass.send(:template, template)

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
  end
end
