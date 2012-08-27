require 'spec_helper'

describe BillingIntegration::Atos::QuickCheckout do
  context "redirect_url" do
    let(:payment_method) { Factory :atos_quick_checkout }
    let(:order) { Factory(:order) }

    it "should return url" do
      ActiveMerchant::Billing::Atos.any_instance.should_receive(:setup_payment_session).and_return('123')
      payment_method.redirect_url(order).should == "#{ActiveMerchant::Billing::Atos.new.service_url}?sid=123"
    end
  end

end
