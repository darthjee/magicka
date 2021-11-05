# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Class representing an element agregator, representing a model
  class Aggregator
    autoload :MethodBuilder, 'magicka/aggregator/method_builder'
    autoload :ClassMethods,  'magicka/aggregator/class_methods'

    class << self
      include Aggregator::ClassMethods
    end

    attr_reader :model
    # @method model
    # 
    # Model where the form elements will focus
    #
    # @return [String]

    # @param renderer [ActionView::Base] Object responsible for rendering
    # @param model [String] Model where the form elements will focus
    def initialize(renderer, model)
      @renderer = renderer
      @model    = model
    end

    # Returns a new aggregator focusing on a new model
    #
    # The new model is an attribute of +model+ unless base is given
    #
    # @param model [String] Model where the form elements will focus
    # @param base [String] Model base
    #
    # @yield [Aggregator] new aggregator focused in the new model
    #
    # @return [Aggregator]
    def with_model(model, base: self.model)
      new_model = [base, model].compact.join('.')

      yield self.class.new(renderer, new_model)
    end

    # Checks if other aggragate is equal to this one
    #
    # @param [Object] other object to be compared
    #
    # @return [TrueClass,FalseClass]
    def equal?(other)
      return unless other.class == self.class

      other.renderer == renderer &&
        other.model == model
    end

    alias == equal?

    protected

    attr_reader :renderer

    delegate :render, to: :renderer
  end
end
