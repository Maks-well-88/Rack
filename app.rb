require_relative 'hendler'

class App

  attr_reader :handler

  def call(env)
    start_hendler(env)
    env['PATH_INFO'] == '/time' ? handler.choose_response : handler.response(404, ["Not found"])
  end

  private

  def start_hendler(env)
    @handler = Hendler.new
    handler.process_the_request(env)
  end
end
