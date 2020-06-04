# frozen_string_literal: true

# @api public
# @author darthjee

require 'sinclair'

# @api public
# @author Darthjee
#
# module holding herlper to render inputs
module Magicka
  autoload :VERSION,     'magicka/version'
  autoload :Aggregator,  'magicka/aggregator'
  autoload :Button,      'magicka/button'
  autoload :Element,     'magicka/element'
  autoload :FormElement, 'magicka/form_element'
  autoload :Form,        'magicka/form'
  autoload :Input,       'magicka/input'
  autoload :Select,      'magicka/select'
  autoload :Text,        'magicka/text'
end
