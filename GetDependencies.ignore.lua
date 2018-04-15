local function GetDependencies(Module, Dependencies)
	-- Gets the Dependency names from a Module
	-- @param LuaSourceContainer Module The Script Object to find dependencies inside of
	-- @optional table Dependencies A table to put the dependencies in
	-- @returns table with dependency names

	if not Dependencies then
		Dependencies = {}
	end

	local Source = Module.Source
	while Source == "" do
		wait()
		Source = Module.Source
	end

	local FunctionNames = {
		["[:.]LoadLibrary"] = Source;
	}

	-- Search for Resources declaration
	-- local ReplicatedStorage = game:GetService("ReplicatedStorage")
	-- local require = require(ReplicatedStorage:WaitForChild("Resources")).LoadLibrary

	-- ReplicatedStorage
	local ReplicatedStorageLocal
	local a, b = Source:match("local%s+(%a[%w_]*)%s*=%s*game:GetService%(?['\"]ReplicatedStorage['\"]%)?%s(.+)")
	if a and b then
		Source = b
		ReplicatedStorageLocal = a
	end

	-- Resources
	local ResourcesLocal
	a, b = Source:match("local%s+(%a[%w_]*)%s*=%s*require%(ReplicatedStorage:WaitForChild%(?['\"]Resources['\"]%)?%)?%s(.+)")
	if a and b then
		Source = b
		ResourcesLocal = a
	end

	-- LoadLibrary functions
	a, b = Source:match("local%s+(%a[%w_]*)%s*=%s*" .. (ResourcesLocal or "require%(" .. (ReplicatedStorageLocal or "game:GetService%(?['\"]ReplicatedStorage['\"]%)?") .. ":WaitForChild%(?['\"]Resources['\"]%)?%)") .. "%.LoadLibrary%s(.+)")
	if a and b then
		Source = b
		FunctionNames[a] = b
	end

	-- Get Localized names for the LoadLibrary Function
	while true do
		local a, b = Source:match("local%s+(%a[%w_]*)%s*=%s*%a[%w_]*%.LoadLibrary.-%s(.+)")
		if a and b then
			Source = b
			FunctionNames[a] = b
		else
			break
		end
	end

	-- Get String Dependencies
	for FunctionName, Source in next, FunctionNames do
		for Dependency in Source:gmatch(FunctionName .. "%s*%(?%s*'(.-)'") do
			Dependencies[Dependency] = true
		end

		for Dependency in Source:gmatch(FunctionName .. "%s*%(?%s*\"(.-)\"") do
			Dependencies[Dependency] = true
		end

		for Dependency in Source:gmatch(FunctionName .. "%s*%(?%s*%[=*%[(.-)%]=*%]") do
			Dependencies[Dependency] = true
		end
	end

	return Dependencies
end

return GetDependencies
