# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Base class for element rendering
  class Element < Sinclair::Options
    autoload :ClassMethods,  'magicka/element/class_methods'
    autoload :MethodBuilder, 'magicka/element/method_builder'

    skip_validation

    class << self
      # @api public
      # @!visibility public
      #
      # Add available options
      #
      # @return [Array<Sinclair::MethodDefinition>]
      alias with_attributes with_options

      include ClassMethods
    end

    # @method with_attributes
    # @api public
    # @!visibility public
    #
    # Adds attribute
    #
    # This will affect initialization and add readers
    #
    # @return [Array]

    # Render element HTML
    # @api private
    #
    # @return [ActionView::OutputBuffer]
    def render
      renderer.render partial: template, locals: locals
    end

    private

    # @api private
    # @private
    # @method renderer
    #
    # Object responsible for rendering the HTML
    #
    # @return [ActionView::Base]
    attr_reader :renderer

    # @api private
    # @private
    #
    # @param (see .render)
    def initialize(renderer:, **args)
      @renderer = renderer
      super(**args)
    end

    # @api private
    # @private
    #
    # Returns hash of local variables
    #
    # Local variablees will be available when rendering
    # the template
    #
    # @return [Hash]
    def locals
      self.class.locals.inject({}) do |hash, attribute|
        hash.merge!(attribute => send(attribute))
      end
    end

    # @api private
    # @private
    #
    # Returns template file location
    #
    # @return [String]
    def template
      @template ||= self
                    .class
                    .name
                    .underscore
                    .gsub(%r{^.*/}, "#{template_folder}/")
    end
  end
end
