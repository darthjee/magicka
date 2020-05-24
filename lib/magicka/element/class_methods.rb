# frozen_string_literal: true

module Magicka
  class Element < Sinclair::Options
    module ClassMethods
      # render template using the given prameters
      #
      # @param renderer [Object] object responsible for rendering
      #   the HTML
      # @param args [Hash] Extra options
      def render(renderer:, **args)
        new(renderer: renderer, **args).render
      end

      def locals
        @locals ||= superclass.try(:locals)&.dup || Set.new([])
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

      def with_locals(*args)
        locals.merge(args)
      end

      def with_attribute_locals(*args)
        with_locals(*args)
        with_attributes(*args)
      end
    end
  end
end
