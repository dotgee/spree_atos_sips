require 'spec_helper'

describe CheckoutController do
  let(:atos_gateway) { BillingIntegration::Atos::QuickCheckout.new :id => 123, :preferred_merchant_id => '987654321' }
  let(:order) { Factory(:order, :state => "payment") }

  before do
    controller.stub(:current_order => order, :check_authorization => true, :current_user => order.user)
    order.stub(:checkout_allowed? => true, :completed? => false)
    order.update!
  end

  it "should understand atos routes" do
    assert_routing("/orders/#{order.number}/checkout/atos_success", {:controller => "checkout", :action => "atos_success", :order_id => order.number })
    assert_routing("/orders/#{order.number}/checkout/atos_cancel", {:controller => "checkout", :action => "atos_cancel", :order_id => order.number })
  end

  context "during payment selection on checkout" do
    it "should setup a purchase transaction and redirect" do
      PaymentMethod.should_receive(:find).at_least(1).with("123").and_return(atos_gateway)
      ActiveMerchant::Billing::Atos.any_instance.should_receive(:setup_payment_session).and_return('abc123')
      post :update, {:order_id => order.number, :state => 'payment', :order => {:payments_attributes => [:payment_method_id => "123" ] } }

      response.should redirect_to 'https://www.moneybookers.com/app/payment.pl?sid=abc123'

      order.payments.size.should == 1
      order.payments.first.source_type.should == 'AtosAccount'
      order.payments.first.pending?.should be_true
    end

  end

  context "with response from Atos" do
    before { Factory(:payment, :order_id => order.id, :source => AtosAccount.find_or_create_by_email(order.email)) }

    it "should redirect to cart on cancel" do
      get :atos_cancel, :order_id => order.number

      response.should redirect_to edit_order_url(order)
    end

    it "should complete order on first success" do
      Order.should_receive(:where).with(:number => order.number).and_return([order])

      order.state.should == 'payment'
      get :atos_success, :order_id => order.number
      order.state.should == 'complete'

      order.completed_at.should_not be_nil

      response.should redirect_to order_path(order)
    end
  end

end

