class ApplicationController < ActionController::Base
  protect_from_forgery

  def decorate(model)
    # If not a model, ignore
    decorator = (model.class.to_s+'Decorator').constantize rescue nil
    decorator ? decorator.decorate(model) : model
  end
end
