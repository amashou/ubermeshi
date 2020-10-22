require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UbermeshiApp
  class Application < Rails::Application
    config.api_only = true
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    Rails.application.config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: 'Content-Type,X-Requested-With,Accept,Origin',
          methods: [:get, :post, :put, :delete, :options]
      end
    end
    
    config.generators do |g|
      g.assets false
      g.helpers false
      g.skip_routes true
      g.test_framework :rspec,
        controller_specs: false,
        view_specs: false,
        helper_specs: false,
        routing_specs: false
    end
  end
end
