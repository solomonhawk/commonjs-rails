require 'commonjs/template'
require 'rails/engine'
require 'sprockets'

module CommonJS
  class Engine < ::Rails::Engine
    config.before_initialize do |app|
      Rails.application.config.assets.paths << root.join("lib", "assets", "javascripts")
      Rails.application.config.assets.paths << root.join("node_modules")

      Sprockets.register_engine '.js', CommonJS::Template
    end
  end
end
