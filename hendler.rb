require_relative 'time_formatter'

class Hendler

  attr_reader :time_formatter

  HEADERS = {'Content-Type' => 'text/plain'}

  def choose_response
    if request_is_valid?
      response(200, ["#{time_formatter.convert_params_for_response}"])
    else
      response(400, ["Unknown time format #{time_formatter.get_unknown_params}"])
    end
  end

  def process_the_request(env)
    @time_formatter = TimeFormatter.new
    time_formatter.get_params_of_request(request(env))
  end

  private

  def request(env)
    Rack::Request.new(env)
  end

  def response(status, body)
    Rack::Response.new(body, status, HEADERS).finish
  end

  def request_is_valid?
    time_formatter.get_unknown_params.empty?
  end
end
