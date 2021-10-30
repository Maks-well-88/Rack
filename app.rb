require 'rake'
require_relative 'hendler'

class App

  attr_reader :handler

  def call(env)
    create_hendler(Rack::Request.new(env).query_string)
    env['PATH_INFO'] == '/time' ? handler.choose_response : handler.response(404, ["Not found"])
  end

  private

  def create_hendler(query_string)
    @handler = Hendler.new
    handler.process_query_string(query_string)
  end
end
