module Spree
  class BillingIntegration::Atos::Sips < BillingIntegration
    preference :merchant_id, :string
    preference :banque, :string, :default => 'sogenactif'
    # preference :facebook_application_url, :string

    attr_accessible :preferred_merchant_id, :preferred_banque, :preferred_server, :preferred_test_mode #, :preferred_facebook_application_url


    def provider_class
      ActiveMerchant::Billing::Atos
    end

    private
      def set_global_options(opts)
        opts[:recipient_description] = Spree::Config[:site_name]
        opts[:payment_methods] = self.preferred_payment_options
      end

  end
end
