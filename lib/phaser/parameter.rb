module Phaser
  class Parameter < Base

    class << self

      def repo_url
        "#{API_URL}/phases"
      end

      def all_for(phase)
        response     = connection.get("#{repo_url}/#{phase.id}/parameters")
        parameters   = JSON.parse(response.body)
        parameters.map { |parameter| new(parameter) }
      end

      def create_for(phase, attributes)
        connection.post("#{repo_url}/#{phase.id}/parameters", attributes)
      end

      def destroy_for(phase, id)
        connection.delete("#{repo_url}/#{phase.id}/parameters/#{id}")
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

    def data_type
      attributes[:data_type]
    end

    def description
      attributes[:description]
    end

  end

  class EmptyParameter
  end

end