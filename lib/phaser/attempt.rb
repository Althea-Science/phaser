module Phaser
  class Attempt < Base

    class << self

      def repo_url
        "#{API_URL}/patients"
      end

      def all_for(patient)
        response = connection.get("#{repo_url}/#{patient.id}/attempts")
        patients = JSON.parse(response.body)
        patients.map { |attempt| new(attempt) }
      end

      def create_for(patient, attributes)
        connection.post("#{repo_url}/#{patient.id}/attempts", attributes)
      end

      def destroy_for(patient, id)
        connection.delete("#{repo_url}/#{patient.id}/attempts/#{id}")
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

  class EmptyAttempt
  end

end