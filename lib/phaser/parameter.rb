require 'faraday'
require 'json'


module Phaser
  class Parameter

    class << self

      API_URL = 'http://localhost:3000/phases'

      def all_for(phase)
        response     = connection.get("#{API_URL}/#{phase.id}/parameters")
        parameters   = JSON.parse(response.body)
        parameters.map { |parameter| new(parameter) }
      end

      def wrap(set)
        set.map { |parameter| new(parameter) }
      end

      def create_for(phase, attributes)
        connection.post("#{API_URL}/#{phase.id}/parameters", attributes)
      end

      def destroy_for(phase, id)
        connection.delete("#{API_URL}/#{phase.id}/parameters/#{id}")
      end

      def connection
        @connection ||= Faraday
      end

    end

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.deep_symbolize_keys
    end

    def id
      attributes[:id]
    end

    def name
      attributes[:name]
    end

  end
end