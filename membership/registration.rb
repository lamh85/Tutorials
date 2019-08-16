module RegisterUser
  class Coordinator
    class << self
      

      private

      def run_tasks
        tasks.each do |task|
          task.call(registration_event)
        end
      end

      def tasks
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