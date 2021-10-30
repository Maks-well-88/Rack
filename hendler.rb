require 'cgi'

class Hendler

  TIME_FORMAT = {
    "year" => "%Y", "month" => "%m", "day" => "%d",
    "hour" => "%H", "minute" => "%M", "second"=> "%S"
  }

  def process_query_string(query_string)
    params_of_request = CGI.parse(query_string)
    @time_params = params_of_request["format"][0].split(',').map(&:downcase).uniq
    @unknown_time_params = @time_params - %w[year month day hour minute second]
  end

  def choose_response
    if @unknown_time_params.any?
      response(400, ["Unknown time format #{@unknown_time_params}"])
    else
      response(200, ["#{set_body_of_success_response}"])
    end
  end

  def set_body_of_success_response
    search_words = /year|month|day|hour|minute|second/
    Time.now.strftime(@time_params.join('-').gsub(search_words, TIME_FORMAT))
  end

  private

  def response(status, body)
    [status, {'Content-Type' => 'text/plain'}, body]
  end
end
