module RegisterUser

  # SUPER ABSTRACT - IE - Should rarely ever change
  class Tasks < ::MembershipTasks
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

  class Coordinator < ::TaskCoordinator
    attr_reader :event
    attr_accessor :intertask_payload, :current_task, :task_result

    def initialize(event)
      @current_task = ''
      @task_result = {}
      @event = event
      @intertask_payload = {}
    end

    def run
      new(event).run_task_list
    end

    private

    def run_task_list
      Tasks.list.each do |task|
        run_task
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
  end

  class CreateMembership
    def run
    end
  end
end