require 'faraday'
require 'json'


module Phaser
  class Phase

    class << self

      API_URL = 'http://localhost:3000/phases'

      def all
        response = connection.get(API_URL)
        phases   = JSON.parse(response.body)
        phases.map { |phase| new(phase) }
      end

      def find(id)
        response = connection.get("#{API_URL}/#{id}")
        phase = JSON.parse(response.body)
        new(phase)
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

    def title
      attributes[:title]
    end

    def order
      attributes[:order]
    end

    def attempts
      attempt_repo.wrap(attributes[:attempts])
    end

    def parameters
      parameter_repo.wrap(attributes[:parameters])
    end

    def charts
      chart_repo.wrap(attributes[:charts])
    end

    def create_parameter(attributes)
      parameter_repo.create_for(self, attributes)
    end

    def destroy_parameter(id)
      parameter_repo.destroy_for(self, id)
    end

    private

    def parameter_repo
      @parameter_repo || Phaser::Parameter
    end

    def attempt_repo
      @attempt_repo || Phaser::Attempt
    end

    def chart_repo
      @attempt_repo || Phaser::Chart
    end

  end
end