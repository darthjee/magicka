# frozen_string_literal: true

module Magicka
  # Helper module to be used on rails
  module Helper
    autoload :ClassMethods,  'magicka/helper/class_methods'
    autoload :MethodBuilder, 'magicka/helper/method_builder'

    class << self
      include Helper::ClassMethods
    end

    with Form
    with Display

    # @method self.with(aggregator_class, type = aggregator_class.type)
    #
    # Adds a helper method magicka_+type+
    #
    # The created method executes a block with a an aggragator
    #
    # @param aggregator_class [Class<Magicka::Aggregator>]
    #   Agragator to be initialized
    # @param type [String,Symbol] type of aggregator,
    #   this will define the method name
    #
    # @return [Array<NilClass>]

    # @method magicka_form(model)
    #
    # Execute a block with an aggregator focused on a model
    #
    # The aggregator renders elements as form elements
    #
    # @param model [String] Model to be processed
    #
    # @yield [Magicka::Form] Agregator to edit a model
    #
    # @see Magicka::Form
    #
    # @return [String]

    # @method magicka_display(model)
    #
    # Execute a block with an aggregator focused on a model
    #
    # The aggregator renders elements as display elements
    #
    # @param model [String] Model to be processed
    #
    # @yield [Magicka::Display] Agregator to show a model
    #
    # @see Magicka::Display
    #
    # @return [String]
  end
end
