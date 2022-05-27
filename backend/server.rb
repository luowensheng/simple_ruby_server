require 'socket'

require_relative "./server/request_details"
require_relative "./server/response_writer"

def info (item)
  puts "{{{{{#{item}}}}}"
end




class Server
    
  def initialize()
    @handlers = {get:[], put:[], post:[], delete:[]}
  end

  def handlers
    @handlers
  end
  def post(pattern, func)
    @handlers[:post].push([pattern, func])
    return
  end
  
  def get(pattern, func)
    @handlers[:get].push([pattern, func])
    return
  end
  
  def put(pattern, func)
    @handlers[:put].push([pattern, func])
    return
  end

  def delete(pattern, func)
    @handlers[:delete].push([pattern, func])
    return
  end

  def start(port=8080)
    server = TCPServer.new port
    puts "server started at http://localhost:#{port}"

    loop do
      Thread.start(server.accept) do |client| 
      writer = ResponseWriter.new

        begin
          request = RequestDetails.new(client)
          puts request
          handle_request(writer, request) 
        rescue  ZeroDivisionError
          puts exception
          handle_error(writer, exception)
        end

        client.puts writer.to_s
        client.close

      end
    end

  end

  def handle_error(writer, exception)
    writer.set_content "[ERROR] #{exception.to_s}"
  end

  def handle_request(writer, request)

    case request.method
      when  "POST"
        writer.set_status_code(201)
      when  "GET"
        writer.set_status_code(200)
      when  "PUT"
        writer.set_status_code(204)
      when  "DELETE"
        writer.set_status_code(204)
    end

    process_request(writer, request)
  
  end

  def process_request(writer, request)
    m = request.method.downcase!.to_sym
    info(request.partial_url)
    for (pattern, func) in @handlers[m]
      puts "[#{m}] comparing [(#{pattern}) vs (#{request.partial_url}) = #{pattern == request.partial_url}]"
        if pattern == request.partial_url
          func.(writer, request)
          # puts writer.to_s
          return
        end
    end 
    if request.partial_url == "/favicon.ico"
      return handle_favicon(writer, request)
    end
    # writer.set_content("method #{m} not found for url #{request.partial_url}")
    # writer.set_status_code(400)
  end

  def handle_favicon(writer, request)
    writer.set_content("[GET] welcome FAVICON")
  end

  def handle_post(writer, request)
    writer.set_content "[POST] #{request}" 
  end

  def handle_put(writer, request)
    writer.set_content "[PUT] #{request}" 
  end

  def handle_delete(writer, request)
    writer.set_content "[DELETE] #{request}" 
  end

  def handle_get(writer, request)
    writer.set_content "[GET] #{request}" 
  end

end
