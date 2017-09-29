require 'test_helper'

class BetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @bet = Bet.new(title: "Philadelphia 76ers", benchmark: 45.4, locked: false)
  end

  test "should be valid" do
    assert @bet.valid?
  end

  test "should have a title" do
    @bet.title = ""
    assert_not @bet.valid?
  end

  test "should have a benchmark" do
    @bet.benchmark = nil
    assert_not @bet.valid?
  end




end
