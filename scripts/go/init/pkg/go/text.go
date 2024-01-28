package init_go

var ModulePathMessage = "\n" + `	The module path is a unique identifier for your module. It's used to
	import packages from your module in other Go programs. When you run go
	mod init, Go uses the argument you pass to generate the module path.

	If you don't want to include your GitHub username in the module path,
	you can simply omit it. For example, if your project name is
	'my_project', you could initialize your Go module like this:

	go mod init my_project

	This command creates a go.mod file in your current directory with module
	my_project at the top. This go.mod file tracks your project's
	dependencies and their versions.`
