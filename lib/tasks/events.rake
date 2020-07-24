# frozen_string_literal: true

namespace :events_manager do
  namespace :events do
    namespace :issue_relation do
      desc 'Envia notificações da criação de um IssueRelation'
      task :create, [:issue_relation_id] => :environment do |_t, args|
        EventsManager.trigger(
          IssueRelation,
          :create,
          IssueRelation.find(args.issue_relation_id)
        )
      end
    end
    namespace :issue do
      desc 'Envia notificações da criação de um Issue'
      task :create, [:issue_id] => :environment do |_t, args|
        EventsManager.trigger(
          Issue,
          :create,
          Issue.find(args.issue_id)
        )
      end

      desc 'Envia notificações da alteração de um Issue'
      task :update, [:journal_id] => :environment do |_t, args|
        EventsManager.trigger(
          Issue,
          :update,
          Journal.find(args.journal_id)
        )
      end
    end
    namespace :repository do
      desc 'Ativa evento de recebimento de conteúdo por repositório'
      task :receive, [:repository_id] => :environment do |_t, args|
        EventsManager.delay_disabled = true
        EventsManager.trigger(
          Repository,
          :receive,
          Repository.find(args.repository_id)
        )
      end
    end
  end
end
