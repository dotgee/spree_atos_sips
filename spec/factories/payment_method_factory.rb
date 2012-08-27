Factory.define(:atos_quick_checkout, :class => BillingIntegration::Atos::QuickCheckout) do |record|
  record.name 'Atos - Quick Checkout'
  record.environment 'test'
end
