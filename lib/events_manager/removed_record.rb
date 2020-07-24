# frozen_string_literal: true

module EventsManager
  class RemovedRecord
    def initialize(record)
      @attributes = record.attributes
      @class = record.class
    end

    def copy_record
      r = @class.new
      @attributes.each do |k, v|
        r.send("#{k}=", v)
      end
      r
    end

    def id
      @attributes[:id]
    end
  end
end
