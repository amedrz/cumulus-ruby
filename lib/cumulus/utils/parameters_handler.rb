module Cumulus
  module Utils
    class ParametersHandler
      attr_reader :parameters, :object

      def initialize(parameters, object)
        @parameters = parameters
        @object = object
      end

      def for_request
        parameters.each_with_object({}) { |j, k| k[j[1]] = object.send(j[0]) }
        .reject { |k, v| v.nil? }
      end

      def set(attributes)
        cleanup(attributes).each { |k, v| object.send("#{k}=", v) }
      end

      def cleanup(attributes)
        Hash[attributes.map { |k, v| [k.to_s, v] }]
        .select { |k, v| parameters.key?(k) }
      end
    end
  end
end
