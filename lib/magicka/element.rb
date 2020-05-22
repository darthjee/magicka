# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Base class for element rendering
  class Element < Sinclair::Options
    skip_validation

    class << self
      # render template using the given prameters
      #
      # @param renderer [Object] object responsible for rendering
      #   the HTML
      # @param args [Hash] Extra options
      def render(renderer:, **args)
        new(renderer: renderer, **args).render
      end

      private

      # @api public
      # @!visibility public
      #
      # Sets template for element type
      #
      # @return [Array<Sinclair::MethodDefinition>]
      def template(template)
        MethodBuilder
          .new(self)
          .add_template(template)
      end
    end

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
      {}
    end
  end
end
