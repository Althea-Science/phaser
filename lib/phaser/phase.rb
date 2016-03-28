module Phaser
  class Phase < Base

    class << self

      def sequential
        all.map { |phase| phase if phase.in_sequence? }.compact
      end

      def nonsequential
        all.map { |phase| phase unless phase.in_sequence? }.compact
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

    def position
      attributes[:position]
    end

    def in_sequence?
      attributes[:in_sequence]
    end

    def active_parameters
      parameters.map { |parameter| parameter if parameter.active? }
    end

    def inactive_parameters
      parameters.map { |parameter| parameter unless parameter.active? }
    end

    def active_parameter_percentage
      return "0%" if parameters.count == 0
      "#{((active_parameters.count / parameters.count.to_f) * 100).round}%"
    end

    def attempts
      attempt_repo.wrap(attributes[:attempts])
    end

    def parameters
      @paramters ||= parameter_repo.wrap(attributes[:parameters], self)
    end

    def charts
      chart_repo.wrap(attributes[:charts])
    end

    def create_parameter(attributes)
      parameter_repo.create_for(self, attributes)
    end

    def update_parameter(id, attributes)
      parameter_repo.update_for(self, id, attributes)
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

  class EmptyPhase < EmptyBase
  end

  class PhaseCollection < BaseCollection

    def collected_class
      Phaser::Phase
    end

  end

end