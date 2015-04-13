local ns_config = {
	namespace_name = "app",

	namespace_modules = {
		helper = "app.helper.",
		config = "app.config.",
		model = "app.modules.model.",
		service = "app.modules.service.",
		view = "app.modules.view.",
		vo = "app.modules.vo"
	},

	namespace_methods = {
		model = function(key, path)
			local arr_ = string.split(key, "_")
			return kode.facade:loadModel(arr_[1], arr_[2])
		end,

		service = function(key, path)
			local arr_ = string.split(key, "_")
			return kode.facade:loadService(arr_[1], arr_[2])
		end,

		view = function(key, path)
			local arr_ = string.split(key, "_")
			return kode.facade:loadView(arr_[1], arr_[2])
		end,

		vo = function(key, path)
			local arr_ = string.split(key, "_")
			return kode.facade:loadVo(arr_[1], arr_[2])
		end
	}
}

kode.register_namespace{
	namespace = ns_config.namespace_name,
	modules = ns_config.namespace_modules,
	methods = ns_config.namespace_methods
}