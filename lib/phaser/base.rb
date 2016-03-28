require 'faraday'
require 'json'

module Phaser

  class Base

    class << self

      def all
        response = connection.get(repo_url)
        items    = JSON.parse(response.body)
        items.map { |item| new(item) }
      end

      def wrap(set)
        collection.new( set.map { |item| new(item) } )
      end

      def find(id)
        if id.nil?
          new_empty_item
        else
          response = connection.get("#{repo_url}/#{id}")
          item     = JSON.parse(response.body)
          new(item)
        end
      end

      def create(attributes)
        response = connection.post(repo_url, attributes)
        if response.success?
          item = JSON.parse(response.body)
          new(item)
        end
      end

      def update(id, attributes)
        connection.put("#{repo_url}/#{id}", attributes)
      end

      def destroy(id)
        connection.delete("#{repo_url}/#{id}")
      end

      def connection
        @connection ||= Faraday
      end

      def repo_url
        @repo_url ||= "#{Phaser.api_url}/#{repo_name}"
      end

      def repo_name
        @repo_name ||= ("#{class_name}s").downcase
      end

      def new_empty_item
        Object.const_get("Phaser::Empty#{class_name}").new
      end

      def class_name
        self.name.split('::')[1]
      end

      def collection
        Collection
      end

    end

    def to_partial_path
      "#{class_name}s/#{class_name}"
    end

    def class_name
      self.class.name.split('::')[1].downcase
    end

  end

  class EmptyBase

    def to_partial_path
      "#{class_name}s/empty_#{class_name}"
    end

    def class_name
      self.class.name.split('::')[1][5..-1].downcase
    end

    def id
      nil
    end

  end

end