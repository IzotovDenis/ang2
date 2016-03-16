require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "order_from" do
    mail = OrderMailer.order_from
    assert_equal "Order from", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
