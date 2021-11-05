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

    # @method self.with
    #
    # Adds a helper method magicka_(type)
    #
    # The created method executes a block with a an aggragator
    #
    # @param aggregator_class [Class<Magicka::Aggregator>] Agragator to be initialized
    # @param type [String,Symbol] type of aggregator, this will define the method name
    #
    # @return Array<NilClass>

    # @method magicka_form
    #
    # Execute a block with an aggregator focused on a model
    #
    # The aggregator renders elements as form elements
    #
    # @param model [String] Model to be processed
    #
    # @yield Render a form using the aggregator
    #
    # @see Magicka::Form
    #
    # @return [String]

    # @method magicka_display
    #
    # Execute a block with an aggregator focused on a model
    #
    # The aggregator renders elements as display elements
    #
    # @param model [String] Model to be processed
    #
    # @yield Render a form using the aggregator
    #
    # @see Magicka::Display
    #
    # @return [String]
  end
end
