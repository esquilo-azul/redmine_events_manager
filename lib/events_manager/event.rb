module EventsManager
  class Event
    attr_reader :entity, :action, :data

    def initialize(entity, action, data)
      @entity = entity
      @action = action
      @data = data
    end

    def to_s
      "#{entity}::#{action}|#{data.class}(#{data.id})"
    end

    def issue_create?
      entity == ::Issue && action == :create
    end

    def issue_update?
      entity == ::Issue && action == :update
    end

    def issue_relation_create?
      entity == ::IssueRelation && action == :create
    end
  end
end
