#https://www6.software.ibm.com/developerworks/education/l-rubysocks/l-rubysocks-a4.pdf
#https://ruby-doc.org/stdlib-2.5.1/libdoc/singleton/rdoc/Singleton.html

require_relative "./server"
require_relative "./loader"

app = Server.new

app.get("/", lambda { |writer, request| 
    writer.set_content("[GET] welcome home")
})
app.put("/", lambda { |writer, request| 
    writer.set_content("[PUT] welcome url")
})
app.post("/", lambda { |writer, request|  
    writer.set_content("[POST] welcome home")
})

app.delete("/", lambda { |writer, request|  
    writer.set_content("[DELETE] welcome home")
})
app.get("/home", lambda { |writer, request|  
 
    writer.set_content(load_html("/public/temp.html"))
})

app.start()

de = "<html><head><title>Example</title></head><body><p>Worked!!!</p></body></html>"
ss = load_html("/public/temp.html")
puts ss == de
puts ss.inspect
puts de
puts ss.valid_encoding?
# puts rb.de