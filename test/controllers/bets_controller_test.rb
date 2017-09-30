require 'test_helper'

class BetsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
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
    log_in_as(@other_user)
    assert_no_difference 'Bet.count' do
      post bets_path, params: { bet: { title: "Duders",
                                       benchmark: 44.4,
                                       locked: false } }
      end
      assert_redirected_to root_url
  end

  test "should redirect destroy when not admin" do
    log_in_as(@other_user)
    assert_no_difference 'Bet.count' do
      delete bet_path(@bet)
    end
    assert_redirected_to root_url
  end

  test "should create a new" do

    
  end





end
