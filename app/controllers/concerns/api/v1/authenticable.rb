# frozen_string_literal: true

module Api
  module V1
    module Authenticable
      extend ActiveSupport::Concern

      def authenticate_user!
        @current_user ||= User.find(jwt_decode["sub"])

        return if @current_user.present?
      rescue ActiveRecord::RecordNotFound
        render json: {message: "unauthorized", code: "unauthenticated"}, status: :unauthorized
      rescue JWT::ExpiredSignature
        render json: {message: "access_token_expired", code: "unauthenticated"}, status: :unauthorized
      rescue JWT::VerificationError, JWT::DecodeError
        render json: {message: "access_token_invalid", code: "unauthenticated"}, status: :unauthorized
      end

      private

      def token
        session[:access_token] || request.headers["Authorization"]&.split&.last
      end

      def jwt_decode
        JsonWebToken.decode(token)
      end
    end
  end
end
