class HomeController < ApplicationController
  actions :index, :show, :foo, :bar
  before_actions [
    {method: authenticate_user, except: [:index]},
    {method: authenticate_admin, only: [:show]},
  ]
  after_actions [
    {method: greet_user, only: [:index]},
    {method: greet_admin, only: [:show]},
  ]

  def index
    response.content_type = "text/plain"
    response.print "Welcome to Takarik! Controller works!"
  end

  def show
    render plain: "Hello, World!"
  end

  def foo
    render plain: "foo"
  end

  def bar
    head :created
  end

  def authenticate_user
    response.status = :unauthorized
    response.content_type = "text/plain"
    response.print "Unauthorized"
    return false
  end

  def authenticate_admin
    response.status = :unauthorized
    response.content_type = "text/plain"
    response.print "Admin required"
    return false
  end

  def greet_user
    response.content_type = "text/plain"
    response.print "Hello, User!"
  end

  def greet_admin
    response.content_type = "text/plain"
    response.print "Hello, Admin!"
  end
end
