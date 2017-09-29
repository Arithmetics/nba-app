require 'test_helper'

class BetsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @bet = bets(:celtics)
  end

  test "should dispaly all the bets available" do
    log_in_as(@user)
    get bets_path
    assert_template 'bets/index'
    Bet.all.each do |bet|
      assert_select 'td', text: bet.title
    end
  end

  test "should redirect create when not admin" do
    assert_no difference 'Bet.count' do
      post bets_path, params: { bet: { title: "Duders",
                                       benchmark: 44.4,
                                       locked: false } }
      end
      assert_redirected_to bets_path
  end

  test "should redirect destroy when not admin" do
    assert_no difference 'Bet.count' do
      delete bet_path(@bet)
    end
    assert_redirected_to bets_path
  end





end
