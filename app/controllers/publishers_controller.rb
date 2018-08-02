# frozen_string_literal: true

# shops

class PublishersController < ApplicationController
  # respond_to :json
  before_action :set_publisher, only: [:shops]

  def show; end

  def shops
    binding.pry
    render status: 200
  end

  protected

  def set_publisher
    @publisher = Publisher.find_by_id(params[:id])
    return render status: 404, json: { errors: [{ code: 404, title: 'Publisher not found' }] } unless @publisher # Вынести errors?
  end
end
