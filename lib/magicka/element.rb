# frozen_string_literal: true

module Magicka
  class Element
    class << self
      def render(*args)
        new(*args).render
      end

      private

      def template(template)
        Sinclair.new(self).tap do |builder|
          builder.add_method(:template) do
            template
          end
        end.build
      end
    end

    def render
      renderer.render partial: template, locals: locals
    end

    private

    attr_reader :renderer

    def initialize(renderer:, **_args)
      @renderer = renderer
    end

    def locals
      {}
    end
  end
end
