class ListenerOption < ActiveRecord::Base
  class << self
    def listener_class_list
      @listener_classes ||= ::EventsManager.all_listeners
    end

    def listener_class_options
      listener_class_list.sort.map { |v| [v, v] }
    end
  end

  validates :listener_class, presence: true, uniqueness: true,
                             inclusion: { in: listener_class_list }
  validates :delay, allow_blank: true,
                    numericality: { integer_only: true }
end
