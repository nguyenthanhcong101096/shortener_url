# frozen_string_literal: true

class ShortenerUrlsController < ApplicationController
  def show
    cmd = ShortenerUrlCommands::Show.call(short_url: params[:id])

    if cmd.success?
      redirect_to cmd.result, allow_other_host: true, status: :found
    else
      render file: Rails.public_path.join("404.html").to_s, layout: false, status: :not_found
    end
  end
end
