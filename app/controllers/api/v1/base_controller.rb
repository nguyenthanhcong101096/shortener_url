# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Api::V1::Authenticable

      before_action :authenticate_user!

      attr_reader :current_user
    end
  end
end
