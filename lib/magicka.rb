# frozen_string_literal: true

# @api public
# @author darthjee

require 'sinclair'

# @api public
# @author Darthjee
#
# module holding herlper to render inputs
module Magicka
  autoload :VERSION,       'magicka/version'
  autoload :Element,       'magicka/element'
  autoload :FormElement,   'magicka/form_element'
  autoload :Input,         'magicka/input'
  autoload :MethodBuilder, 'magicka/method_builder'
  autoload :Select,        'magicka/select'
end
