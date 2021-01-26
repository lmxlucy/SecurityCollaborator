require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SecurityCollaborator
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    Figaro.load
    config.load_defaults 6.0
    config.gmail_username = ENV["gmail_username"]
    config.gmail_password = ENV["gmail_password"]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
