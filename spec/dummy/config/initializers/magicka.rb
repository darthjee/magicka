# frozen_string_literal: true

require 'magicka'

Magicka::Helper.with('Magicka::WebForm', :web_form) do
  with(Magicka::WebInput)
end
