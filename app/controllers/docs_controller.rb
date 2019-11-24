# frozen_string_literal: true

class DocsController < ApplicationController
  def show
    path = params[:path]
    path += ".#{params[:format]}"

    path = Rails.root.join('docs', path)
    send_file path, disposition: :inline
  end
end
