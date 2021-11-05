# frozen_string_literal: true

module Magicka
  module Helper
    # Class methods for {Magicka::Helper}
    module ClassMethods
      # (see Magicka::Helper.with)
      #
      # @param (see Magicka::Helper.with)
      def with(aggregator_class, type = aggregator_class.type)
        MethodBuilder.new(self).build_aggregator(aggregator_class, type)
      end
    end
  end
end
