require 'faraday'
require 'json'


module Phaser
  class Attempt

    class << self

      API_URL = 'http://localhost:3000/patients'

      def all_for(patient)
        response = connection.get("#{API_URL}/#{patient.id}/attempts")
        patients = JSON.parse(response.body)
        patients.map { |attempt| new(attempt) }
      end

      def wrap(set)
        set.map { |attempt| new(attempt) }
      end

      def create_for(patient, attributes)
        connection.post("#{API_URL}/#{patient.id}/attempts", attributes)
      end

      def destroy_for(patient, id)
        connection.delete("#{API_URL}/#{patient.id}/attempts/#{id}")
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

    def count
      attributes[:count]
    end

    def patient
      Phaser::Patient.new(attributes[:patient])
    end

    def phase
      Phaser::Phase.new(attributes[:phase])
    end

    def values
      Phaser::Value.wrap(attributes[:values])
    end

  end
end