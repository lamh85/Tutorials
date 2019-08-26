# Possible tasks
  # Database CRUD
    # user
    # membership
    # access right
  # Stripe CRUD
    # customer
    # subscription
    # source

# SUPER ABSTRACT - IE - Should rarely ever change
module TaskList
  class Registration < ::MembershipTaskList
    class << self
      def list
        [
          CreateStripeCustomer,
          CreateUser,
          CreateStripeSubscription,
          CreateMembership
        ]
      end
    end
  end
end

class TaskCoordinator
  attr_reader :event, :task_list
  attr_accessor :intertask_payload, :current_task, :task_result

  def initialize(event, task_list)
    @current_task = ''
    @task_result = {}
    @event = event
    @intertask_payload = {}
    @task_list = task_list
  end

  def call
    new(event).run_task_list
  end

  private

  def run_task_list
    ActiveRecord::Base.transaction do
      task_list.list.each do |task|
        begin
          run_task
        rescue
          handle_failed_task
        end
      end
    end

    # Do something if succeeds?
  end

  def run_task
    current_task = task.to_s
    task_result = task.run(event, intertask_payload)
    handle_failed_task if (task_result[:status] == :error)
    intertask_payload[current_task] = task_result[:payload]
  end

  def handle_failed_task
    # raise with following info:
      # task_result
      # current_task
  end

  def report_sentry
  end
end