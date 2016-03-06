require 'faraday'
require 'json'


module Phaser
  class Chart

    class << self

      API_URL = 'http://localhost:3000/charts'

      def all
        response = connection.get(API_URL)
        charts   = JSON.parse(response.body)
        charts.map { |chart| new(chart) }
      end

      def wrap(set)
        set.map { |attempt| new(attempt) }
      end

      def find(id)
        response = connection.get("#{API_URL}/#{id}")
        chart = JSON.parse(response.body)
        new(chart)
      end

      def create(attributes)
        connection.post(API_URL, attributes)
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

    def patient
      Phaser::Patient.new(attributes[:patient])
    end

  end
end