# frozen_string_literal: true

module EventsManager
  module Patches
    module Repository
      module GitPatch
        def fetch_changesets
          super
          EventsManager.trigger(::Repository, :receive, self)
        end
      end
    end
  end
end

unless ::Repository::Git.included_modules.include?(EventsManager::Patches::Repository::GitPatch)
  ::Repository::Git.prepend(EventsManager::Patches::Repository::GitPatch)
end
