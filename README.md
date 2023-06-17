# Service
The 'Service' module is designed to represent a top-level client singleton, this module is designed to be used inside of the Infinity framework, however is a package of it's own in the case that the Infinity Framework isn't suitable for your application.

This project took inspiration from Knit's 'Service' implementation & has attempted to improve the control flow designed in the service itself.

> ⚠️ Each service will inherit a 'Reporter' - these reporters stem from the '4x8matrix/Console' package and will allow developers to configure the schema, log level and have a better grip on the output these services will create.

## Examples
Brief documentation to go through the functionality:

```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Service = require(ReplicatedStorage.Packages.Service)

local ExampleService = Service.new({
	Name = "ExampleService"
})

function ExampleService.Internal:Abc()
	self.Service:Abc()
end

function ExampleService:Abc()
	self.Reporter:Debug("Hey, looks like the control flow is working!")
end

function ExampleService:Test()
	self.Internal:Abc()
end

ExampleService:Test()
```