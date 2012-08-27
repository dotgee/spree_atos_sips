module SpreeAtos
  class Engine < Rails::Engine
    engine_name 'atos_sips'

    config.autoload_paths += %W(#{config.root}/lib)

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc

    initializer "atos_sips.register.payment_methods", :after => 'spree.register.payment_methods' do |app|
      app.config.spree.payment_methods += [
        Spree::BillingIntegration::Atos::Sips
      ]
    end

  end
end
