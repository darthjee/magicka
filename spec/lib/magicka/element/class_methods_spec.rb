# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Element::ClassMethods do
  subject(:element) { klass.new(renderer: renderer) }

  let(:klass) do
    Class.new(Magicka::Element)
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
      expect { klass.template(template) }
        .to add_method(:template)
        .to(klass)
    end

    context 'when method is build as requested' do
      before { klass.template(template) }

      it 'returns the defined template when method is called' do
        expect(element.template).to eq(template)
      end
    end
  end

  describe '.render' do
    before do
      klass.template(template)

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
    it { expect(Magicka::Element.locals).to eq(Set.new([])) }

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
        .not_to change(Magicka::Element, :locals)
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

  describe 'with_attribute_locals' do
    it do
      expect { klass.send(:with_attribute_locals, :field, :model) }
        .to change(klass, :locals)
        .from([])
        .to(%i[field model])
    end

    it do
      expect { klass.send(:with_attribute_locals, :field, :model) }
        .not_to change(Magicka::Element, :locals)
    end

    it do
      expect { klass.send(:with_attribute_locals, :field) }
        .to add_method(:field)
        .to(klass)
    end

    context 'when called on subclass' do
      let(:subclass) { Class.new(klass) }

      before { klass.send(:with_attribute_locals, :field, :model) }

      it do
        expect { subclass.send(:with_attribute_locals, :error) }
          .to change(subclass, :locals)
          .from(%i[field model])
          .to(%i[field model error])
      end

      it do
        expect { subclass.send(:with_attribute_locals, :error) }
          .not_to change(klass, :locals)
      end
    end
  end
end
