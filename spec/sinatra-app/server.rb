require 'sinatra'
require 'haml'

require 'action_view'
require_relative '../../app/helpers/stable_helper'
include StableHelper

helpers do
  def render(*args)
    # HACK to load gem partial view
    if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
      partial = args.first[:partial]
      location = File.join("../../../app/views", File.split(partial)[0], "_#{File.split(partial)[1]}") 
      options = { :locals => args.last[:locals] } # .merge(:layout => false)
      return haml location.to_sym, options 
    else
      super
    end
  end
end

get '/' do
  haml :index
end

