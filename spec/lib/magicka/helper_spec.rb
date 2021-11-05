# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Helper do
  subject(:object) { klass.new }

  let(:klass) do
    Class.new do
      include Magicka::Helper
    end
  end

  let(:model) { 'model' }

  describe '#magicka_display' do
    it do
      object.magicka_display(model) do |display|
        expect(display).to be_a(Magicka::Display)
      end
    end

    it 'populates the model' do
      object.magicka_display(model) do |display|
        expect(display.model).to eq(model)
      end
    end

    it 'populates the renderer' do
      object.magicka_display(model) do |display|
        expect(display.send(:renderer)).to eq(object)
      end
    end
  end

  describe '#magicka_form' do
    it do
      object.magicka_form(model) do |form|
        expect(form).to be_a(Magicka::Form)
      end
    end

    it 'populates the model' do
      object.magicka_form(model) do |form|
        expect(form.model).to eq(model)
      end
    end

    it 'populates the renderer' do
      object.magicka_form(model) do |form|
        expect(form.send(:renderer)).to eq(object)
      end
    end
  end
end
