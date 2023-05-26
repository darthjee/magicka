# frozen_string_literal: true

require 'magicka'

Magicka::Helper.with('Magicka::DataTable', :data_table) do
  with_element(Magicka::DataEntry)
end
