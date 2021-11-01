# frozen_string_literal: true

require_relative 'time_formatter'

class Hendler
  attr_reader :time_formatter

  HEADERS = { 'Content-Type' => 'text/plain' }.freeze

  def choose_response
    if time_formatter.params_of_request_is_empty?
      response(400, ['Missing request parameters'])
    elsif request_is_invalid?
      response(400, ["Unknown time format #{time_formatter.get_unknown_params}"])
    else
      response(200, [time_formatter.convert_params_for_response.to_s])
    end
  end

  def process_the_request(env)
    @time_formatter = TimeFormatter.new
    time_formatter.get_params_of_request(Rack::Request.new(env))
  end

  def response(status, body)
    Rack::Response.new(body, status, HEADERS).finish
  end

  def request_is_invalid?
    time_formatter.get_unknown_params.any?
  end
end
