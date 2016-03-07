module Phaser
  class Phase < Base

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