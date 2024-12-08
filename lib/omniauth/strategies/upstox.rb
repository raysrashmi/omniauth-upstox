# frozen_string_literal: true

# This file implements the Upstox strategy for OmniAuth.

require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Upstox < OmniAuth::Strategies::OAuth2
      option :name, "upstox"
      option :client_options, {
        site: "https://api.upstox.com",
        authorize_url: "https://api.upstox.com/v2/login/authorization/dialog",
        token_url: "https://api.upstox.com/v2/login/authorization/token"
      }

      def callback_url
        options[:redirect_uri] || (full_host + callback_path)
      end

      def authorize_params
        super.tap do |params|
          params[:response_type] = "code"
        end
      end

      def token_params
        super.tap do |params|
          params[:redirect_uri] = options[:redirect_uri]
          params[:client_secret] = options[:client_secret]
          params[:client_id] = options[:client_id]
        end
      end

      uid { request.params["user_id"] }

      info do
        {
          name: raw_info["name"],
          location: raw_info["city"]
        }
      end

      extra do
        {
          "raw_info" => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/v2/user/profile").parsed
      end

      def email
        raw_info["email"]
      end
    end
  end
end
