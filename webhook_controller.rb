class WebhookController
  def take_action
    StripeEventHandler.run(stripe_event)
  end
end

class StripeEventHandler
  attr_reader :stripe_event

  def initialize(stripe_event)
    @stripe_event = stripe_event
  end

  def self.run(stripe_event)
    handler = new(stripe_event)

    handler.send_metric
    handler.update_membership
    handler.update_extension
    handler.update_stripe
  end

  private

  def send_metric
    return unless ['customer.updated', 'customer.created'].includes? stripe_event[:event_type]
  end

  def update_membership
  end

  def update_extension
  end

  def update_stripe
  end

  def email_user
  end
end