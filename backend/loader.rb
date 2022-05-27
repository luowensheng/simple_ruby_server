def load_html(path)
    fullpath =  __dir__ + path
    begin
       File.open(fullpath).read
    rescue Errno::ENOENT
        "Failed to read file"
    end    
end

