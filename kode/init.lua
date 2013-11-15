kode = {}

require "kode.object"
require "kode.ext.init"
require "kode.helpers.init"
require "kode.mvc.init"

-- avoid memory leak
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)