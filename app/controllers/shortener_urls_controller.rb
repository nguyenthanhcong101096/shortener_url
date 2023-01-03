# frozen_string_literal: true

class ShortenerUrlsController < ApplicationController
  def show
    cmd = ShortenerUrlCommands::Show.call(short_url: params[:id])

    if cmd.success?
      redirect_to cmd.result, allow_other_host: true, status: 302
    else
      render file: Rails.root.join('public/404.html').to_s, layout: false, status: :not_found
    end
  end
end
