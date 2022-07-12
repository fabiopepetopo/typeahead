# frozen_string_literal: true

class TypeaheadController < ApplicationController
  def search
    @results = TypeaheadService.instance.search(params[:prefix])
    render :search, status: :ok
  end

  def update
    @result = TypeaheadService.instance.update(params[:name])
    render :update, status: :created
  end
end
