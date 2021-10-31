require 'cgi'

class TimeFormatter

  TIME_FORMAT = {
    "year" => "%Y", "month" => "%m", "day" => "%d",
    "hour" => "%H", "minute" => "%M", "second"=> "%S"
  }

  def get_params_of_request(request)
    params_of_request = CGI.parse(request.query_string)
    @time_params = params_of_request["format"][0].split(',').map(&:downcase).uniq
  end

  def get_unknown_params
    @unknown_time_params = @time_params - %w[year month day hour minute second]
  end

  def convert_params_for_response
    search_words = /year|month|day|hour|minute|second/
    Time.now.strftime(@time_params.join('-').gsub(search_words, TIME_FORMAT))
  end
end
