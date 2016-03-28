module Phaser
  class Chart < Base

    class << self

      def create_multiple(attributes)
        connection.post("#{repo_url}/multi", attributes)
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

    def attempt
      Phaser::Attempt.new(attributes[:attempt])
    end

    def phase
      Phaser::Phase.new(attributes[:phase])
    end

  end

  class EmptyChart < EmptyBase
  end

  class AttemptCollection < BaseCollection

    def collected_class
      Phaser::Chart
    end

  end

end