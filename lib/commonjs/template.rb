require "open3"
require 'json'
require 'pathname'

module CommonJS
  class Template < Tilt::Template
    BROWSERIFY_CMD = "./node_modules/.bin/browserify".freeze
    WRAPPER        = "%s.define({%s:function(exports, require, module){%s}});\n"

    class << self
      attr_accessor :default_namespace
    end

    self.default_mime_type = 'application/javascript'
    self.default_namespace = 'this.require'

    def prepare
      @namespace = self.class.default_namespace
    end

    def evaluate(context, locals, &block)
      directory = File.dirname(file)
      command = "#{browserify_cmd} #{ file } #{options}"

      env = {
        "NODE_PATH" => asset_paths
      }

      deps, stderr, status = Open3.capture3(env, command, stdin_data: data, chdir: directory)

      if !status.success?
        raise CommonJS::Error.new("Error while running `#{command}`:\n\n#{stderr}")
      end

      context.require_asset('commonjs')

      JSON.parse(deps).each do |d|
        context.require_asset(d['file'])
      end

      WRAPPER % [ namespace, context.logical_path, data ]
    end

    private

    def asset_paths
      @asset_paths ||= Rails.application.config.assets.paths.collect { |p| p.to_s }.join(":") || ""
    end

    def browserify_cmd
      cmd = File.join(Rails.root, BROWSERIFY_CMD)

      if !File.exist?(cmd)
        raise CommonJS::Error.new("browserify could not be found at #{cmd}. Please run npm install.")
      end

      cmd
    end

    def options
      '--deps --noparse'
    end

    private

    attr_reader :namespace

  end
end
