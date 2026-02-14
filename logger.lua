local now = function()
	return os.time() -- TODO: human dates
end

---@class Logger.Opts
---@field name? string "log service name"
---@field level? "INFO" | "DEBUG" | "WARN" | "ERROR" | "FATAL" "log level"
---@field message string "log message"
---
---@class Level.Opts
---@field name? string "log service name"
---@field level? "INFO" | "DEBUG" | "WARN" | "ERROR" | "FATAL" "log level"
---
---@class Setup.Opts
---@field name? string "log service name"

--- logs to stdout
---
--- usage:
--- log("hello world", "DEBUG", "logger.lua")
---
--- output:
--- [1771099245] [DEBUG] [logger.lua]: hello world
---
--- @param opts Logger.Opts
local log = function(opts)
	if opts.name == nil then
		if opts.level == nil then
			print(string.format("[%s]: %s", now(), opts.message))
			return
		end

		print(string.format("[%s] [%s]: %s", now(), opts.level, opts.message))
		return
	end

	print(string.format("[%s] [%s] [%s]: %s", now(), opts.level, opts.name, opts.message))
end

--- @param opts Level.Opts
local level = function(opts)
	--- logs to the specified level
	---
	--- example usage:
	---	```
	--- local logger = require("logger").setup({
	--- 	name = "example.lua"
	--- })
	--- logger.info("hello world")
	--- ```
	---
	--- example output:
	---
	--- \[1771099245\] \[DEBUG\] \[logger.lua\]: hello world
	---
	--- @param message string "log message"
	return function(message)
		log({
			message = message,
			level = opts.level,
			name = opts.name,
		})
	end
end

---@param config Setup.Opts
local setup = function(config)
	return {
		info = level({
			name = config.name,
			level = "INFO",
		}),
		debug = level({
			name = config.name,
			level = "DEBUG",
		}),
		warn = level({
			name = config.name,
			level = "WARN",
		}),
		error = level({
			name = config.name,
			level = "ERROR",
		}),
	}
end

return { setup = setup }
