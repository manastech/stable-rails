require 'sinatra'
require 'haml'
require 'sass'
require 'action_view'
require 'sprockets'
require_relative '../../app/helpers/stable_helper'
include StableHelper

set :assets, Sprockets::Environment.new
settings.assets.append_path "../../app/assets/javascripts"
settings.assets.append_path "../../app/assets/stylesheets"

helpers do
  def render(*args)
    # HACK to load gem partial view
    if args.first.is_a?(Hash) && args.first.keys.include?(:partial)
      partial = args.first[:partial]
      location = File.join("../../../app/views", File.split(partial)[0], "_#{File.split(partial)[1]}") 
      options = { :locals => args.last[:locals] }
      return haml location.to_sym, options 
    else
      super
    end
  end
end

get '/' do
  haml :index
end

get "/javascripts/:file.js" do
  content_type "application/javascript"
  settings.assets["#{params[:file]}.js"]
end

get "/stylesheets/:file.css" do
  content_type "text/css"
  settings.assets["#{params[:file]}.css"]
end

