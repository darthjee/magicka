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
    # @api public
    #
    # Model where the form elements will focus
    #
    # @return [String]

    # @method self.with_element(element_class, method_name = nil, template: nil)
    #
    # Configure an {Aggregator} adding a method to render an element
    #
    # @param element_class [Class<Magicka::ELement>]
    #   Class of the element to be rendered
    # @param method_name [String,Symbol]
    #   Name of the method that will render the element
    # @param template [String] custom template file to be used
    #
    # @see Aggregator::ClassMethods#with_element
    # @see Aggregator::MethodBuilder
    #
    # @return [Array<NilClass>]

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

    # @api private
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
    # @method renderer
    # @private
    # @api private
    #
    # Returns the element needed to render the view
    #
    # @return [ActionView::Base]

    delegate :render, to: :renderer
  end
end
