# frozen_string_literal: true

module RedmineEventsManager
  module Patches
    module Repository
      module GitPatch
        def fetch_changesets
          super
          RedmineEventsManager.trigger(::Repository, :receive, self)
        end
      end
    end
  end
end

unless Repository::Git.included_modules
         .include?(RedmineEventsManager::Patches::Repository::GitPatch)
  ::Repository::Git.prepend(RedmineEventsManager::Patches::Repository::GitPatch) # rubocop:disable Style/RedundantConstantBase
end
