require "takarik"

# Base abstract controller for all controllers
abstract class ApplicationController < Takarik::BaseController
  include Takarik::Views::ECRRenderer

  layouts :application
end
