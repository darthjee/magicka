# frozen_string_literal: true

module Magicka
  class Element < Sinclair::Options
    # @api public
    #
    # Class methods used for metaprograming of elements
    module ClassMethods
      # render template using the given prameters
      #
      # @param renderer [Object] object responsible for rendering
      #   the HTML
      # @param args [Hash] Extra options
      def render(renderer:, **args)
        new(renderer: renderer, **args).render
      end

      # list of attributes to be used when rendering
      #
      # @return [Set<Symbol>]
      def locals
        @locals ||= superclass.try(:locals)&.dup || Set.new([])
      end

      # Sets template for element type
      #
      # @return [Array<Sinclair::MethodDefinition>]
      def template(template)
        MethodBuilder
          .new(self)
          .add_template(template)
      end

      def template_folder(folder)
        MethodBuilder
          .new(self)
          .add_template_folder(folder)
      end

      private

      # @api public
      # @!visibility public
      #
      # Add an attribute to locals when rendereing
      #
      # the attribute will be a call to the a method
      # with same name
      #
      # @return [Set<Symbol>]
      def with_locals(*args)
        locals.merge(args)
      end

      # @api public
      # @!visibility public
      #
      # Adds attribute and locals
      #
      # @return [Array]
      def with_attribute_locals(*args)
        with_locals(*args)
        with_attributes(*args)
      end
    end
  end
end
