#encoding:utf-8
class AtosController < ApplicationController
  before_filter :restore_session, :only => [:atos_confirm, :atos_cancel]

  respond_to :html

  def atos_confirm
    banque = Spree::Preference.where(:key => "spree/billing_integration/atos/sips/banque/#{Spree::PaymentMethod.where(:type => "Spree::BillingIntegration::Atos::Sips", :active => 1).first.id}").first.value
    @response_array = AtosPayment.new(
      :banque => banque
    )
    .response(params[:DATA])

    @order = Spree::Order.find(@response_array[:order_id])
    # session[:order_id] = @order.id

    # Si le paiement a été effectué
    if @response_array[:response_code] == "00"
      # Si la commande existe et que le montant dû est égal au montant payé
      if @order.present? && (@order.total.to_f*100).to_i == @response_array[:amount].to_i
        @order.state = "complete"
        @order.payment_state = "paid"
        @order.completed_at = Time.now
        @order.save
        session[:order_id] = nil
        flash[:notice] = "Le paiement a été effectué avec succès"
        redirect_to "/orders/#{@order.number}"
      else
        flash[:error] = "Le prix de vos achats (#{(@order.total.to_f*100).to_i}) et le montant que vous avez payé (#{@response_array[:amount]}) diffèrent"
        redirect_to "/"
      end
    else
      flash[:error] = "Erreur : #{response_array[:error].gsub(/<\/?[^>]*>/, '')}"
      redirect_to "/"
    end
  end


  def atos_cancel
    @order = Spree::Order.find(@response_array[:order_id])
    session[:order_id] = @order.id
    flash[:error] = "Paiement annule. Choisissez une autre méthode de paiement ou <a href='/'>continuez vos achats</a>".html_safe
    redirect_to "/checkout/payment"
  end


  def atos_auto_response
    banque = Spree::Preference.where(:key => "spree/billing_integration/atos/sips/banque/#{Spree::PaymentMethod.where(:type => "Spree::BillingIntegration::Atos::Sips", :active => 1).first.id}").first.value
    @response_array = AtosPayment.new(
      :banque => banque
    )
    .response(params[:DATA])

    @order = Spree::Order.find(@response_array[:order_id])

    # Si le paiement a été effectué
    if @response_array[:response_code] == "00"
      # Si la commande existe et que le montant dû est égal au montant payé
      if @order.present? && (@order.total.to_f*100).to_i == @response_array[:amount].to_i
        @order.state = "complete"
        @order.payment_state = "paid"
        @order.completed_at = Time.now
        @order.save
        session[:order_id] = nil
      end
    end
  end

  private
    def restore_session
      banque = Spree::Preference.where(:key => "spree/billing_integration/atos/sips/banque/#{Spree::PaymentMethod.where(:type => "Spree::BillingIntegration::Atos::Sips", :active => 1).first.id}").first.value
      @response_array = AtosPayment.new(
        :banque => banque
      )
      .response(params[:DATA])
      @user = Spree::User.find(@response_array[:customer_id])
      sign_in(@user)
    end

    def restore_session_on_facebook
      banque = Spree::Preference.where(:key => "spree/billing_integration/atos/sips/banque/#{Spree::PaymentMethod.where(:type => "Spree::BillingIntegration::Atos::Sips", :active => 1).first.id}").first.value
      @response_array = AtosPayment.new(
        :banque => banque
      )
      .response(params[:signed_request])
      @user = Spree::User.find(@response_array[:customer_id])
      sign_in(@user)
    end
end
