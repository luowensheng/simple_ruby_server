class ResponseWriter
    attr_reader :http_version, :status_code, :content, :content_type
  
    def initialize()
      @content_type = "text/html"
      @status_code = 200
      @http_version = "HTTP/1.1"
      @content = ""
    end
  
    def set_http_version(value) 
        @http_version = value 
    end
    def set_status_code(value)
      @status_code = value 
    end
    def set_content_type(value)
      @content_type = value 
    end
    def set_content(content) 
      @content = content.to_s
      # puts @content
    end
  
    def add_content(content, sep="")
        @content = sep + content;
    end
  
    def to_s()
      #  data="#{@http_version} #{@status_code} OK\r\n"
      #  data+="Content-Type:#{@content_type}\r\n"
      #  data+="Content-Length:#{@content.length}"
      #  data+="\r\n\r\n"
      #  data+="#{@content}" # 2
      #  return data
      content = "<html><head><title>Example</title></head><body><p>Worked!!!</p></body></html>"
      data= "HTTP/1.1 200 OK\r\n"
      data+= "Content-Type: text/html\r\n"
      # # data+="Content-Length:#{@content.length}"
      data+="\r\n\r\n"
      puts "\n\n\n$$$$$$$$$$$  #{content==@content}\n\n"
      data+=@content # 2
      puts data.inspect
      return data
    end 
  end