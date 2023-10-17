# Remote Access

This page introduces lab network configurations and access methods to operate lab computers remotely. 



### Network Configuration

All servers are connected to the NYU network with the IP address in [Basic Lab Info: Network Configuration](_pages/basic_lab_info.md#network-configuration). 

Note that the NYU network is encrypted and private. So, the IP addresses above are all private. We need to connect to the NYU private network via *cisco anyconnect*, and then we can access the server. See [NYU Virtual Private Network (VPN)](https://www.nyu.edu/life/information-technology/infrastructure/network-services/vpn.html).

**Note:** *cisco anyconnect* software is available for Windows and MacOS. If you want to use VPN on Linux systems, *openconnect SSL* is recommended as a substitute for *cisco anyconnect*. The installation and connection steps are as follows.

```bash
$ sudo apt install openconnect  # install OpenConnect
$ openconnect vpn.nyu.edu       # connect to NYU vpn
```
Next, choose `NYU VPN: All Traffic``. Then, follow the instructions for connections.



### Remote Access via SSH 

<<<<<<< HEAD
SSH or Secure Shell is a network protocol that offers clients remote operations to the server, such as login, remote command line, etc. We use the `ssh` command to directly access the **Linux server**. 

The `ssh` command, by default, provides a command line interface (CLI) to interact with the host computer. Graphic interfaces require the client machine to run an [X server](https://en.wikipedia.org/wiki/X.Org_Server).
=======
SSH or Secure Shell is a network protocol that offers clients remote operations to the server such as login, remote command-line, etc. We use the `ssh` command to access the **Linux server** directly. 

By default, the `ssh` command provides a command line interface (CLI) to interact with the host computer. Graphic interfaces require the client machine to run an [X server](https://en.wikipedia.org/wiki/X.Org_Server).
>>>>>>> larx_resource/main

For Linux clients, the X server is automatically installed. For Windows and MacOS clients, we need to install an X server to use graphic applications in the Linux host.


#### SSH in Linux

SSH can provide graphic and non-graphic support for computers with Linux systems to access the Linux server remotely. The ssh format of `ssh` goes as follows.

```bash
$ ssh [option] username@host_ip_address
```

For example,

```bash
$ ssh foo@x.x.x.x	 	  # access user account foo with CLI only
$ ssh -X foo@x.x.x.x 	# access user account foo by enabling graphic interfaces.
```

<<<<<<< HEAD
`ssh -X` means enabling `X11` forwarding. `X11` is a window system for bitmap displays, and it provides a framework for a GUI environment. Take MATLAB, for example. We cannot visualize the MATLAB graphic interface if we do not include `-X` option. However, the graphic interface is available if we include `-X`.
=======
`ssh -X` means enabling `X11` forwarding. `X11` is a window system for bitmap displays, and it provides a framework for a GUI environment. Take MATLAB, for example. We cannot visualize the MATLAB graphic interface if we do not include the `-X` option. However, the graphic interface is available if we include `-X`.
>>>>>>> larx_resource/main

After the login, we can use the command line to start an application. 


#### SSH in MacOS

SSH for non-graphic applications for MacOS is the same as above because MacOS is a Unix-like OS. However,  MacOS native applications do not use the X protocol for the rendering but the Mac-specific protocol. So, we cannot use ssh X protocol forwarding as we could with a Linux server. To enable graphic application, we must install an X server on MacOS and have the Linux program appear on Mac. 

[*XQuartz*](https://www.xquartz.org/) is the most common X server implementation for MacOS and is free. The following websites and videos give a good tutorial for *XQuartz* installation:

- [Instructions to Connect to a Remote Linux Server and Open a Graphical Program](https://princetonuniversity.github.io/PUbootcamp/ssh-instructions/)
- [Installing or Reinstalling XQuartz](https://www.l3harrisgeospatial.com/Support/Self-Help-Tools/Help-Articles/Help-Articles-Detail/ArtMID/10220/ArticleID/23855/Installing-or-Reinstalling-XQuartz-if-Upgrade-to-macOS-1015-Catalina-Causes-Issues)
- [Connect to Graphical Applications on Linux using XQuartz on a Mac](https://www.youtube.com/watch?v=s6e3cqCISaE)


#### SSH in Windows
Windows uses other network protocols rather than SSH for remote access. Therefore, we must install SSH client software and an X server to enable graphic applications in the Linux host. 

[PuTTY](https://www.putty.org/) is the most common SSH client software for Windows. Follow the instructions on the website to install PuTTY.

There are many X servers for Windows, for example, [Xming](http://www.straightrunning.com/XmingNotes/), [VcXsrv](https://sourceforge.net/projects/vcxsrv/). See [X servers for Windows](https://teamdynamix.umich.edu/TDClient/47/LSAPortal/KB/ArticleDet?ID=1797) for a complete review.

It is recommended to use [MobaXterm](https://mobaxterm.mobatek.net/), which contains both SSH client and X server. It is free, and the UI is also friendly.

**Note:** The latest Windows 10 and Windows 11 builds include a built-in SSH server and client based on OpenSSH, a connectivity tool for remote sign-in that uses the SSH protocol. Therefore, basic SSH operations with a command line can be performed without installing SSH software.  



### Graphic Interface in Modern Software

When using `ssh -X`, the server returns the display information and sends it back to the client. The client will interpret the display information and display it to the user. This process is generic and can be applied to any software with a graphic interface. However, the access process can be slow because of a huge amount of display information. 

<<<<<<< HEAD
In practice, many software programs do not need to enable `-X` option to have a graphic interface. They only require the server and software to have the same software. The server runs the software and sends the computation back only. The client software receives the computation results and displays the result to the user directly. No additional display information needs to be transmitted. The following figure shows two different modes. 
=======
In practice, many software does not need to enable the `-X` option to have a graphic interface. They only require the server and software to have the same software. The server runs the software and sends the computation back only. The client software receives the computation results and displays the result to the user directly. No additional display information needs to be transmitted. The following figure shows two different modes. 
>>>>>>> larx_resource/main

![img](../_media/ssh_graphics.png)

Many software such as *VS code* and *PyCharm* all follow the same pattern. SSH configurations of the software are discussed in [Installed Software](_pages/installed_software.md)

(to be updated...)


#### Interpretation of `-X` Parameter

(to be updated...)



#### Remote Access via VNC

Virtual Network Computing (VNC) is a graphical desktop-sharing system that uses the Remote Frame Buffer protocol (RFB) to control another computer remotely. 

(to be updated...)



