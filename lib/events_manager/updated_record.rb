# frozen_string_literal: true

module EventsManager
  class UpdatedRecord
    attr_reader :record, :changes

    def initialize(record)
      @record = record
      @changes = record.changes
    end

    delegate :id, to: :record
  end
end
