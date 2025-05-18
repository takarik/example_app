class FoosController < ApplicationController
  actions :index

  def index
    render plain: "Foos index"
  end
end