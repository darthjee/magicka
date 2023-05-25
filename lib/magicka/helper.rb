# frozen_string_literal: true

module Magicka
  # @api public
  #
  # Helper module to be used on rails
  module Helper
    autoload :AggregatorOptions, 'magicka/helper/aggregator_options'
    autoload :ClassMethods,      'magicka/helper/class_methods'
    autoload :MethodBuilder,     'magicka/helper/method_builder'

    extend Helper::ClassMethods

    with Form
    with Display

    # @method self.with(aggregator_class, type = aggregator_class.type, &config_block)
    # @api public
    #
    # Adds a helper method magicka_+type+
    #
    # The created method executes a block with a an aggragator
    #
    # @param aggregator_class [Class<Magicka::Aggregator>]
    #   Agragator to be initialized
    # @param type [String,Symbol] type of aggregator,
    #   this will define the method name
    # @param config_block [Proc] block to be evaluated and configure the aggregator
    #   when it is first used
    #
    # @return [Array<NilClass>]

    # @method magicka_form(model)
    # @api public
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
    # @api public
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
