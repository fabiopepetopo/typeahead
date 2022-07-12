# frozen_string_literal: true

class PingController < ApplicationController
  def pong
    render '/root.json'
  end
end
