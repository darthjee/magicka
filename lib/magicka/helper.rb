# frozen_string_literal: true

module Magicka
  # Helper module to be used on rails
  module Helper
    autoload :ClassMethods, 'magicka/helper/class_methods'

    class << self
      include Helper::ClassMethods
    end

    with Form
    with Display
  end
end
