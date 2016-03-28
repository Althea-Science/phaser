module Phaser
  class Attempt < Base

    class << self

      def repo_url
        "#{Phaser.api_url}/patients"
      end

      def all_for(patient)
        response = connection.get("#{repo_url}/#{patient.id}/attempts")
        patients = JSON.parse(response.body)
        patients.map { |attempt| new(attempt) }
      end

      def search(query)
        response = connection.get("#{Phaser.api_url}/attempt-search/?query=#{query}")
        patients = JSON.parse(response.body)
        patients.map { |attempt| new(attempt) }
      end

      def create_for(patient, attributes)
        response = connection.post("#{repo_url}/#{patient.id}/attempts", attributes)
        if response.success?
          item = JSON.parse(response.body)
          new(item)
        end
      end

      def destroy_for(patient, id)
        response = connection.delete("#{repo_url}/#{patient.id}/attempts/#{id}")
        if response.success?
          item = JSON.parse(response.body)
          new(item)
        end
      end

      def move_to_phase(patient, id, attributes)
        connection.put("#{repo_url}/#{patient.id}/attempts/#{id}/move_to_phase", attributes)
      end

    end

    attr_reader :attributes

    def initialize(attributes)
      @attributes = attributes.deep_symbolize_keys
    end

    def id
      attributes[:id]
    end

    def count
      attributes[:count]
    end

    def date_started
      attributes[:date_started]
    end

    def created_at
      @created_at ||= DateTime.parse(attributes[:created_at])
    end

    def patient_age
      return nil if patient.birthday.nil?

      dob = patient.birthday
      now = created_at
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

    def patient
      @patient ||= Phaser::Patient.new(attributes[:patient])
    end

    def phase
      @phase ||= Phaser::Phase.new(attributes[:phase])
    end

    def values
      @values ||= Phaser::Value.wrap(attributes[:values])
    end

  end

  class EmptyAttempt < EmptyBase
  end

  class AttemptCollection < BaseCollection

    def collected_class
      Phaser::Attempt
    end

  end

end