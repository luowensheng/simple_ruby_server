class RequestDetails 
    attr_reader :method, :url, :http_version, :header, :body, :partial_url
    def initialize(session)
      @method, @url, @http_version = session.gets.split(" ")
      @header = parse_header(session)
      if @header["User-Agent"].split(" ").count > 3
        @url = @header["Referer"]
      end 
      @body = session.read(@header["Content-Length"].to_i)
      _, _, @partial_url =  @url.to_s.partition("http://"+@header["Host"])
    end
  
    private def parse_header(session)
      headers = {}
      while line = session.gets.split(' ', 2)             
        break if line[0] == ""                          
        headers[line[0].chop] = line[1].strip          
      end
      headers
    end
  
    def to_s
      "{method:\"#{@method}\", url:\"#{@url}\", http_version:\"#{@http_version}\", header:#{@header}, body:#{@body}}"
    end
      
  end