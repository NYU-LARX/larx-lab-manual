# VS Code

VS code can be started via
- Command line `code`
- Icon in the application list

To access VS Code remoted, please refer to the following official instruction: [Remote Development using SSH](https://code.visualstudio.com/docs/remote/ssh). To summarize,
- The client computer should install *openssh-client* package and VS Code. 
- The client VS Code shoudl install *Remote Development* extension.

**Note:** For the first time when a client tries to connect to the server, the client should configure the host server properly according to the official tutorial. After the configuration, the client can simply connect VS Code without additional configuration.