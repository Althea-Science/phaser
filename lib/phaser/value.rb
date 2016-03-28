module Phaser
  class Value < Base

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

  class EmptyValue < EmptyBase
  end

  class ValueCollection < BaseCollection
  end

end