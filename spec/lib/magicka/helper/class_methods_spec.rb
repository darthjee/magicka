# frozen_string_literal: true

require 'spec_helper'

describe Magicka::Helper::ClassMethods do
  subject(:object) { klass.new }

  let(:model) { Object.new }

  let(:helper_class) { Magicka::Helper }
  let(:klass) do
    Class.new do
      include Magicka::Helper
    end
  end

  describe '#with' do
    let(:aggregator_class) do
      Class.new(Magicka::Aggregator) do
        def self.name
          'Magicka::MyClass'
        end
      end
    end

    context 'when passing a class' do
      it do
        expect { helper_class.with(aggregator_class) }
          .to add_method('magicka_my_class')
          .to(object)
      end

      context 'when the method is called' do
        before { helper_class.with(aggregator_class) }

        it do
          object.magicka_my_class(model) do |aggregator|
            expect(aggregator).to be_a(aggregator_class)
          end
        end
      end
    end

    context 'when passing a string as agregator' do
      let(:aggregator_name)       { :Test1Aggregator }
      let(:aggregator_class_name) { "Magicka::#{aggregator_name}" }

      it do
        expect { helper_class.with(aggregator_class_name, :test1_aggregator) }
          .to add_method('magicka_test1_aggregator')
          .to(object)
      end

      context 'when the method is called' do
        before do
          helper_class.with(aggregator_class_name, :test1_aggregator)

          Magicka.const_set(aggregator_name, aggregator_class)
        end

        it do
          object.magicka_test1_aggregator(model) do |aggregator|
            expect(aggregator).to be_a(aggregator_class)
          end
        end
      end
    end
  end
end
