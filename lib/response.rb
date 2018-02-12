class Request
  def request
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end
  end

  def specify
    "<pre>
          Verb:     #{request_lines[0].split[0]}
          Path:     #{request_lines[0].split[1]}
          Protocol: #{request_lines[0].split[2]}
          Host:     #{request_lines[1].split[1].split(':')[0]}
          Port:     #{request_lines[1].split[1].split(':')[1]}
          Origin:   #{request_lines[1].split[1].split(':')[0]}
          Accept:   #{request_lines[6].split[1]}
    </pre>"
  end
end
