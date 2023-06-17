return function()
	local Service = require(script.Parent)

	local uniqueServiceName = "Service_"
	local uniqueServiceIndex = 0

	beforeEach(function()
		uniqueServiceName = "Service_" .. uniqueServiceIndex

		uniqueServiceIndex += 1
	end)

	describe("Instantiating a new 'Service' object", function()
		it("Should be able to generate a new 'Service' class", function()
			expect(function()
				local service = Service.new({
					Name = uniqueServiceName
				})

				expect(service.Reporter).to.be.ok()
				expect(service.Internal).to.be.ok()
				expect(service.Services).to.be.ok()

				expect(service.Name).to.equal(uniqueServiceName)
			end).never.to.throw()
		end)

		it("Should throw when given an invalid service block", function()
			expect(function()
				Service.new({
					Name = 123
				})
			end).to.throw()

			expect(function()
				Service.new({ })
			end).to.throw()

			expect(function()
				Service.new()
			end).to.throw()
		end)

		it("Should throw when attempting to create two services of the same name", function()
			expect(function()
				Service.new({ Name = uniqueServiceName })
				Service.new({ Name = uniqueServiceName })
			end).to.throw()
		end)

		it("Should be able to validate a new 'Service' class", function()
			expect(function()
				local service = Service.new({
					Name = uniqueServiceName
				})

				expect(Service.is(service)).to.equal(true)
				expect(Service.is(CFrame.new())).to.equal(false)
			end).never.to.throw()
		end)
	end)

	describe("'Service' lifecycle methods", function()
		it("Should be able to invoke service lifecycle methods", function()
			expect(function()
				local service = Service.new({
					Name = uniqueServiceName
				})

				function service:Test()
					self.TestFlag = true
				end

				service:InvokeLifecycle("Test")

				expect(service.TestFlag).to.equal(true)
			end).never.to.throw()
		end)

		it("Should be able to return the result of an invoked lifecycle method", function()
			expect(function()
				local service = Service.new({
					Name = uniqueServiceName
				})

				function service:Test()
					return 1
				end

				expect(service:InvokeLifecycle("Test")).to.equal(1)
			end).never.to.throw()
		end)

		it("Should be able to compute varadic parameters", function()
			expect(function()
				local service = Service.new({
					Name = uniqueServiceName
				})

				function service:Test(index, value)
					self[index] = value
				end

				service:InvokeLifecycle("Test", "TestFlag", 10)

				expect(service.TestFlag).to.equal(10)
			end).never.to.throw()
		end)
	end)
end