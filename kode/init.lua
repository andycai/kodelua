kode = kode or {}

require "kode.object"
require "kode.ext.init"
require "kode.helpers.init"
require "kode.mvc.init"

-- avoid memory leak
-- collectgarbage("collect")
collectgarbage("setpause", 100)
collectgarbage("setstepmul", 5000)