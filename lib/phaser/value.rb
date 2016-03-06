require 'faraday'
require 'json'


module Phaser
  class Value

    class << self

      API_URL = 'http://localhost:3000/values'

      def all
        response = connection.get(API_URL)
        values   = JSON.parse(response.body)
        values.map { |value| new(value) }
      end

      def wrap(set)
        set.map { |value| new(value) }
      end

      def find(id)
        response = connection.get("#{API_URL}/#{id}")
        value = JSON.parse(response.body)
        new(value)
      end

      def create(attributes)
        connection.post(API_URL, attributes)
      end

      def update(id, attributes)
        connection.put("#{API_URL}/#{id}", attributes)
      end

      def destroy(id)
        connection.delete("#{API_URL}/#{id}")
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

    def data
      attributes[:data]
    end

    def parameter_id
      attributes[:parameter_id]
    end

    def attempt_id
      attributes[:attempt_id]
    end

  end
end