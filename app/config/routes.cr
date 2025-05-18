# Define application routes using the Takarik router DSL
require "../controllers/application_controller.cr"
require "../controllers/home_controller.cr"
require "../controllers/users_controller.cr"
require "../controllers/admins_controller.cr"
require "../controllers/foos_controller.cr"
require "../controllers/bars_controller.cr"
require "log"

Log.debug { "Defining routes..." }

Takarik::Router.define do
  # Basic routes with explicit controller
  get "/",      controller: HomeController, action: :index
  get "/show",  controller: HomeController, action: :show
  get "/foo",   controller: HomeController, action: :foo
  get "/bar",   controller: HomeController, action: :bar

  # Controller-scoped routes
  map UsersController do
    get "/users",      action: :index
    get "/users/new",  action: :new
    get "/users/:id",  action: :show
    post "/users",     action: :create
  end

  # Controller with both explicit routes and resources
  map BarsController do
    get "/bars/:id",  action: :show

    # Resource with filtered actions (no block)
    resources :bars,  except: [:show, :create, :update, :destroy]
  end

  # Simple resource with only specific actions
  resources :foos, controller: FoosController, only: [:index]

  # Full resource with nested collection/member blocks
  resources :admins, controller: AdminsController do
    # Routes applied to the collection (/admins/...)
    collection do
      get "/baz", action: :baz
    end

    # Routes applied to individual resources (/admins/:id/...)
    member do
      get "/qux", action: :qux
    end
  end
end

Log.debug { "Routes defined." }