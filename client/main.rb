require "net/http"

url = URI.parse("http://localhost:8080/home")
# req = Net::HTTP::Get.new(url.to_s)
params = { :limit => 10, :page => 3}
# url.query = URI.encode_www_form(params)
req = Net::HTTP::Get.new(url.to_s)

request_params =  {
  recipient: {id: "sender"},
  message: {text: "text"},
  access_token: "token"
}
req.body = request_params.to_s


response = Net::HTTP.start(url.host, url.port) { |http| 
    # http.use_ssl = true
    # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.request(req)
}
puts "response body = [#{response.body}]"
puts response.code
