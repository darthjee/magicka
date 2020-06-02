# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Base class for element rendering
  class Element < Sinclair::Options
    autoload :ClassMethods, 'magicka/element/class_methods'

    skip_validation

    class << self
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
    def render
      renderer.render partial: template, locals: locals
    end

    private

    attr_reader :renderer
    # @api private
    # @private
    # @method renderer
    #
    # Object responsible for rendering the HTML

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

    # @api public
    # @private
    #
    # Returns template file location
    #
    # @return [String]
    def template
      name.underscore
          .gsub(%r{^.*/}, "#{template_folder}/")
    end
  end
end
