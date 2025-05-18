class BarsController < ApplicationController
  actions :index

  def index
    render plain: "Bars index"
  end
end