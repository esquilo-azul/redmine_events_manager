# coding: utf-8

require 'redmine'

require 'events_manager/patches/issue_patch'

Redmine::Plugin.register :events_manager do
  name 'Events Manager'
  author 'Eduardo Henrique Bogoni'
  description 'Management for events'
  version '0.1.0'
end
