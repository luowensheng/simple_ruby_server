```
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

```