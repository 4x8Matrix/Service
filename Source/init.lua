-- // Imports
local Console = require(script.Parent.Console)
local Types = require(script.Types)

-- // Module
local Service = {}

Service.Type = "Service"

Service.Reporter = Console.new()

Service.Internal = {}
Service.Instances = {}
Service.Interface = {}
Service.Prototype = {}

-- // Internal functions
function Service.Internal:Fill(object, index, value)
	if not object[index] then
		object[index] = value
	end
end

-- // Prototype functions
function Service.Prototype:InvokeLifecycle(method, ...)
	if not self[method] then
		return
	end

	return self[method](self, ...)
end

function Service.Prototype:ToString()
	return `{Service.Type}<"{self.Name}">`
end

-- // Module functions
function Service.Interface.new(serviceSource)
	Service.Reporter:Assert(type(serviceSource) == "table", `Unable to cast {typeof(serviceSource)} to Table`)
	Service.Reporter:Assert(type(serviceSource.Name) == "string", `Unable to cast field 'Name' {typeof(serviceSource.Name)} to Table`)
	Service.Reporter:Assert(Service.Instances[serviceSource.Name] == nil, `{serviceSource.Name} service already exists`)

	if getmetatable(serviceSource) then
		Service.Reporter:Warn(`Overwriting {serviceSource.Name} source table's metatable`)
	end

	serviceSource.Reporter = Console.new(serviceSource.Name)

	Service.Internal:Fill(serviceSource, "Services", { })
	Service.Internal:Fill(serviceSource, "Internal", {
		Service = serviceSource,
		Services = serviceSource.Services
	})

	Service.Instances[serviceSource.Name] = setmetatable(serviceSource, {
		__type = Service.Type,
		__index = Service.Prototype,
		__tostring = function(self)
			return self:ToString()
		end
	})

	return Service.Instances[serviceSource.Name]
end

function Service.Interface.is(object)
	if typeof(object) ~= "table" then
		return false
	end

	local objectMetatable = getmetatable(object)

	if not objectMetatable then
		return false
	end

	return objectMetatable.__type == Service.Type
end

return Service.Interface :: Types.Interface
