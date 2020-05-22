# frozen_string_literal: true

module Magicka
  class Element
    class << self
      def render(*args)
        new(*args).render
      end

      private

      def template(template)
        MethodBuilder
          .new(self)
          .add_template(template)
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
