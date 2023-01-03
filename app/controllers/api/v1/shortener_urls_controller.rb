# frozen_string_literal: true

module Api
  module V1
    class ShortenerUrlsController < BaseController
      def decode
        cmd = ShortenerUrlCommands::Show.call(short_url: params[:short_url])

        if cmd.success?
          render json: {origin_url: cmd.result}, status: :ok
        else
          render json: {errors: cmd.errors.full_messages}, status: :unprocessable_entity
        end
      end

      def encode
        cmd = ShortenerUrlCommands::Create.call(user: current_user, params: params)

        if cmd.success?
          render json: {short_url: [request.env["HTTP_HOST"], cmd.result].join("/")}, status: :ok
        else
          render json: {errors: cmd.errors.full_messages}, status: :unprocessable_entity
        end
      end
    end
  end
end
