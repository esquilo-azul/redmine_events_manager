# frozen_string_literal: true

require 'delayed_job_active_record'

require 'events_manager/patches/issue_patch'
require 'events_manager/patches/issue_relation_patch'
require 'events_manager/patches/journal_patch'
require 'events_manager/patches/test_case_patch'
require 'events_manager/patches/time_entry_patch'
require 'events_manager/patches/repository/git_patch'
require 'events_manager'
require_dependency 'events_manager/hooks/add_assets'
