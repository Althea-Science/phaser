module Phaser
  class Parameter < Base

    class << self

      def repo_url
        "#{Phaser.api_url}/phases"
      end

      def all_for(phase)
        fetch_set("#{repo_url}/#{phase.id}/parameters")
      end

      def create_for(phase, attributes)
        response = connection.post("#{repo_url}/#{phase.id}/parameters", attributes)
        new_for(response)
      end

      def update_for(phase, id, attributes)
        response = connection.put("#{repo_url}/#{phase.id}/parameters/#{id}", attributes)
        new_for(response)
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

    def active?
      attributes[:active]
    end

  end

  class EmptyParameter < EmptyBase
  end

  class ParameterCollection < BaseCollection

    def collected_class
      Phaser::Parameter
    end

  end

end