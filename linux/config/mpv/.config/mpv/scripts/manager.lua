-- this is a modified version of: https://github.com/po5/mpv_manager

local utils = require("mp.utils")
local legacy = mp.command_native_async == nil
local config = {}
local dir_cache = {}

-- add MPV's scripts directory to Lua's package search path
package.path = mp.command_native({ "expand-path", "~~/scripts" }) .. "/?.lua;" .. package.path
local log = require("simple_logger")

log.set_level("TRACE")
-- log.set_level("INFO")

local function run(args)
	local result = legacy and utils.subprocess({ args = args })
		or mp.command_native({ name = "subprocess", capture_stdout = true, playback_only = false, args = args })
	if result.status ~= 0 then
		log.warn("Command failed: %s", table.concat(args, " "))
		return nil
	end
	return result
end

function parent(path)
	return string.match(path, "(.*)[/\\]")
end

function cache(path)
	local p_path = parent(path)
	log.trace("cache: %s p_path: %s", path, p_path)
	if p_path == nil or p_path == "" or dir_cache[p_path] then
		return
	end
	cache(p_path)
	dir_cache[path] = 1
end

function mkdir(path)
	if dir_cache[path] then
		return
	end
	log.trace("git init %s", path)
	cache(path)
	run({ "git", "init", path })
end

function match(str, patterns)
	for pattern in string.gmatch(patterns, "[^|]+") do
		if string.match(str, pattern) then
			log.trace("%s matches %s", str, patterns)
			return true
		end
	end
end

function apply_defaults(info)
	if info.git == nil then
		return false
	end
	if info.whitelist == nil then
		info.whitelist = ""
	end
	if info.blacklist == nil then
		info.blacklist = ""
	end
	if info.dest == nil then
		info.dest = "~~/scripts"
	end
	if info.branch == nil then
		info.branch = "master"
	end
	return info
end

function update(info)
	info = apply_defaults(info)
	if not info then
		return false
	end

	local base = nil

	local e_dest = string.match(mp.command_native({ "expand-path", info.dest }), "(.-)[/\\]?$")
	mkdir(e_dest)

	local files = {}

	run({ "git", "-C", e_dest, "remote", "add", "manager", info.git })
	run({ "git", "-C", e_dest, "remote", "set-url", "manager", info.git })
	run({ "git", "-C", e_dest, "fetch", "manager", info.branch })
	log.trace("git -C %s remote add manager %s", e_dest, info.git)
	log.trace("git -C %s remote set-url manager %s", e_dest, info.git)
	log.trace("git -C %s fetch manager %s", e_dest, info.branch)

	for file in
		string.gmatch(
			run({ "git", "-C", e_dest, "ls-tree", "-r", "--name-only", "remotes/manager/" .. info.branch }).stdout,
			"[^\r\n]+"
		)
	do
		local l_file = string.lower(file)
		if info.whitelist == "" or match(l_file, info.whitelist) then
			if info.blacklist == "" or not match(l_file, info.blacklist) then
				table.insert(files, file)
				if base == nil then
					base = parent(l_file) or ""
				end
				while string.match(base, l_file) == nil do
					if l_file == "" then
						break
					end
					l_file = parent(l_file) or ""
				end
				base = l_file
			end
		end
	end

	if base == nil then
		return false
	end

	if base ~= "" then
		base = base .. "/"
	end

	if next(files) == nil then
	else
		for _, file in ipairs(files) do
			local based = string.sub(file, string.len(base) + 1)
			local p_based = parent(based)
			if p_based and not info.flatten_folders then
				mkdir(e_dest .. "/" .. p_based)
			end
			local c = string.match(
				run({ "git", "-C", e_dest, "--no-pager", "show", "remotes/manager/" .. info.branch .. ":" .. file }).stdout,
				"(.-)[\r\n]?$"
			)
			local f = io.open(e_dest .. "/" .. (info.flatten_folders and file:match("[^/]+$") or based), "w")
			f:write(c)
			f:close()
		end
	end
	return true
end

function update_all()
	log.info("updating packages...")
	local f = io.open(mp.command_native({ "expand-path", "~~/manager.json" }), "r")
	if f then
		local json = f:read("*all")
		f:close()

		local props = utils.parse_json(json or "")
		if props then
			config = props
		end
	else
		log.warn("no config was file found...")
	end

	for i, info in ipairs(config) do
		log.debug("update: %d sucess: %s", i, update(info) and "true" or "false")
	end
	log.info("finished update")
end

mp.add_key_binding(nil, "manager-update-all", update_all)
