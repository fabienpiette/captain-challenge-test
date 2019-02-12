# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CaptainChallenge
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    #
    # Load Paths
    #
    lib_paths = Dir[
      Rails.root.join('lib').to_s,
      Rails.root.join('lib', 'strategies').to_s
    ]
    config.autoload_paths   += lib_paths
    config.eager_load_paths += lib_paths
    config.eager_load       = true
  end
end
