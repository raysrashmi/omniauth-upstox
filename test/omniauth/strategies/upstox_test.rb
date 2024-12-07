# frozen_string_literal: true

require_relative "../../test_helper"
require "ostruct"
require "omniauth/strategies/upstox"

class UpstoxStrategyTest < Minitest::Test
  def setup
    @strategy = OmniAuth::Strategies::Upstox.new(nil, "client_id", "client_secret")
  end

  def test_has_correct_name
    assert_equal "upstox", @strategy.options.name
  end

  def test_client_options
    assert_equal "https://api.upstox.com", @strategy.options.client_options.site
    assert_equal "https://api.upstox.com/v2/login/authorization/dialog", @strategy.options.client_options.authorize_url
    assert_equal "https://api.upstox.com/v2/login/authorization/token", @strategy.options.client_options.token_url
  end

  def test_callback_url
    @strategy.options.redirect_uri = "https://custom-callback.com"
    assert_equal "https://custom-callback.com", @strategy.callback_url
  end

  def test_token_params
    @strategy.options.client_secret = "custom_secret"
    @strategy.options.client_id = "custom_id"
    @strategy.options.redirect_uri = "https://custom-callback.com"

    params = @strategy.token_params
    assert_equal "custom_secret", params[:client_secret]
    assert_equal "custom_id", params[:client_id]
    assert_equal "https://custom-callback.com", params[:redirect_uri]
  end

  def test_raw_info
    mock_access_token = Minitest::Mock.new
    mock_access_token.expect :get, OpenStruct.new(parsed: { "name" => "John Doe", "city" => "New York" }),
                             ["/v2/user/profile"]

    # Inject the mock access token
    @strategy.instance_variable_set(:@access_token, mock_access_token)

    raw_info = @strategy.raw_info

    assert_equal "John Doe", raw_info["name"]
    assert_equal "New York", raw_info["city"]
    mock_access_token.verify
  end

  def test_uid
    mock_request = Minitest::Mock.new
    mock_request.expect :params, { "user_id" => "12345" }

    # Inject the mock request
    @strategy.instance_variable_set(:@env, { "omniauth.strategy" => @strategy })
    @strategy.instance_variable_set(:@request, mock_request)

    assert_equal "12345", @strategy.uid
    mock_request.verify
  end

  def test_info
    mock_raw_info = { "name" => "John Doe", "city" => "New York" }
    @strategy.instance_variable_set(:@raw_info, mock_raw_info)

    info = @strategy.info
    assert_equal "John Doe", info[:name]
    assert_equal "New York", info[:location]
  end
end
