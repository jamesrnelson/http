require './lib/router'

# Takes instruction from router class about what to output
class Output
  def initialize
  end

  def default_output
    @message = 'This is the default output.'
    output
  end

  def hello_world_message
    @message = "Hello, World! (#{@hello_count})"
    output
    @hello_count += 1
  end

  def datetime_message
    @message = current_time
    output
  end

  def shutdown
    @message = "Total Requests: #{@total_count}"
    @client.close
    @close = true
    output
  end

  def search_dictionary
    word = path.split('=')[1]
    if File.read('/usr/share/dict/words').include?(word)
      @message = "#{word} is a known word."
    else
      @message = "#{word} is not a known word."
    end
    output
  end

  def game_info
    @message = "You have made #{guess_count} guesses."
  end

  def entire_message
    '<html><head></head><body>' + @message + '</body></html>' \
      "<pre>
      Verb:     #{@request_lines[0].split[0]}
      Path:     #{@request_lines[0].split[1]}
      Protocol: #{@request_lines[0].split[2]}
      Host:     #{@request_lines[1].split[1].split(':')[0]}
      Port:     #{@request_lines[1].split[1].split(':')[1]}
      Origin:   #{@request_lines[1].split[1].split(':')[0]}
      </pre>"
  end

  def output
    @total_count += 1
    @client.puts headers
    @client.puts entire_message
  end

  def content_length
    @request_lines.find do |request|
      request.include?('Content')
    end.split(' ')[1].to_i
  end
end
