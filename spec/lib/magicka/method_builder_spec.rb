# frozen_string_literal: true

require 'spec_helper'

describe Magicka::MethodBuilder do
  subject(:builder) { described_class.new(klass) }

  let(:klass)    { Class.new }
  let(:instance) { klass.new }

  describe '#add_template' do
    let(:template) { 'path_to_template' }

    it do
      expect { builder.add_template(template) }
        .to add_method(:template)
        .to(klass)
    end

    context 'when method is build as requested' do
      before { builder.add_template(template) }

      it 'returns the defined template when method is called' do
        expect(instance.template).to eq(template)
      end
    end
  end
end
