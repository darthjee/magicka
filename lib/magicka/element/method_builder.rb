# frozen_string_literal: true

module Magicka
  class Element
    # @api private
    #
    # class responsible for building methods on {Magicka::Element}
    class MethodBuilder < Sinclair
      # adds a mehtod +#template+
      #
      # The method will always return the template given in the params
      #
      # @param template [String] path to template file
      #
      # @return [Array<Sinclair::MethodDefinition>]
      def add_template(template)
        add_method(:template) do
          template
        end

        build
      end

      # adds a mehtod +#template_folder+
      #
      # The method will always return the template folder given in the params
      #
      # @param template_folder [String] path to template folder
      #
      # @return [Array<Sinclair::MethodDefinition>]
      def add_template_folder(folder)
        add_method(:template_folder) do
          folder
        end

        build
      end
    end
  end
end
