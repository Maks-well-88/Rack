# frozen_string_literal: true

require 'cgi'

class TimeFormatter
  attr_reader :params_of_request, :time_params

  TIME_FORMAT = {
    'year' => '%Y', 'month' => '%m', 'day' => '%d',
    'hour' => '%H', 'minute' => '%M', 'second' => '%S'
  }.freeze

  def get_params_of_request(request)
    @params_of_request = CGI.parse(request.query_string)
    params_of_request_is_empty? ? @time_params = [] : take_params_for_response
  end

  def take_params_for_response
    @time_params = params_of_request['format'][0].split(',').map(&:downcase).uniq
  end

  def take_unknown_params
    @unknown_time_params = time_params - %w[year month day hour minute second]
  end

  def convert_params_for_response
    search_words = /year|month|day|hour|minute|second/
    Time.now.strftime(time_params.join('-').gsub(search_words, TIME_FORMAT))
  end

  def params_of_request_is_empty?
    params_of_request['format'].empty?
  end
end
