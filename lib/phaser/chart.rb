module Phaser
  class Chart < Base

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

  end

  class EmptyChart < EmptyBase
  end

end