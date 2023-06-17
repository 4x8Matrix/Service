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