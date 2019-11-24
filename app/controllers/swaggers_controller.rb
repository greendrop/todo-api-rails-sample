# frozen_string_literal: true

class SwaggersController < ApplicationController
  def show
    render layout: 'swagger'
  end
end
