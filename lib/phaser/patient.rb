require 'faraday'
require 'json'


module Phaser
  class Patient

    class << self

      API_URL = 'http://localhost:3000/patients'

      def all
        response = connection.get(API_URL)
        patients   = JSON.parse(response.body)
        patients.map { |patient| new(patient) }
      end

      def find(id)
        response = connection.get("#{API_URL}/#{id}")
        patient = JSON.parse(response.body)
        new(patient)
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

    def name
      attributes[:name]
    end

    def attempts
      attempt_repo.wrap(attributes[:attempts])
    end

    def create_attempt(attributes)
      attempt_repo.create_for(self, attributes)
    end

    def destroy_attempt(id)
      attempt_repo.destroy_for(self, id)
    end

    def move_attempt_to_phase(id, phase_id)
      attempt_repo.move_to_phase(self, id, phase_id)
    end

    private

    def attempt_repo
      @parameter_repo || Phaser::Attempt
    end

  end
end