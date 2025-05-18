class AdminsController < ApplicationController
  actions :index, :show, :baz

  def index
    render plain: "Admins index"
  end

  def show
    render plain: "Admins show"
  end

  def baz
    render plain: "Admins baz"
  end
end
