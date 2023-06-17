type Dictionary<I, V> = { [I]: V }
type Array<T> = { [number]: T }

export type Reporter = {
	FetchLogs: (self: Reporter, count: number) -> { [number]: { logType: string, message: string, logId: string } },

	SetState: (self: Reporter, state: boolean) -> (),
	SetLogLevel: (self: Reporter, logLevel: number) -> (),

	Debug: (self: Reporter, ...any) -> (),
	Log: (self: Reporter, ...any) -> (),
	Warn: (self: Reporter, ...any) -> (),
	Error: (self: Reporter, ...any) -> (),
	Critical: (self: Reporter, ...any) -> (),

	Assert: (self: Reporter, condition: boolean, ...any) -> ()
}

export type Service = {
	Name: string,
	Reporter: Reporter,

	Internal: Dictionary<any, any>,
	Services: Dictionary<string, Service>,

	ToString: (self: Service) -> string,
	InvokeLifecycle: (method: string, ...any) -> ...any
}

export type Interface = {
	new: (serviceSource: {
		Name: string,

		Internal: Dictionary<any, any>?,
		Services: Dictionary<string, Service>?,
	}) -> Service,

	is: (object: Service?) -> boolean
}

return { }