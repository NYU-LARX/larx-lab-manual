# Remote Access

This page introduces lab network configurations and access methods to remotely operate lab computers. 



### Network Configuration

All servers are connected to the NYU network with the IP address in [Basic Lab Info: Network Configuration](_pages/basic_lab_info.md#network-configuration). 

Note that NYU network is an encriptied and private network. So the IP addresses above are all private addresses. We need to connect the NYU private network via *cisco anyconnect*, then we are able to access the server. See [NYU Virtual Private Network (VPN)](https://www.nyu.edu/life/information-technology/infrastructure/network-services/vpn.html).

**Note:** *cisco anyconnect* software is available for Windows and MacOS. If you want to use VPN on Linux systems, *openconnect SSL* is recommended as a substitute of *cisco anyconnect*. The installation and connection steps are as follows.

```bash
$ sudo apt install openconnect  # install OpenConnect
$ openconnect vpn.nyu.edu       # connect to NYU vpn
```
Next, choose `NYU VPN: All Traffic``. Then follow the instruction for connections.



### Remote Access via SSH 

SSH or Secure Shell is a network protocol which offers clients remote operations to the sever such as login, remote command-line, etc. We use `ssh` command to access the **Linux server** directly. 

`ssh` command by default provides a command line interface (CLI) to interact with the host computer. Graphic interfaces requires the client machine to run an [X server](https://en.wikipedia.org/wiki/X.Org_Server).

For Linux clients, X server is automatically installed. For Windows and MacOS clients, we need to install an X server to use graphic applications in the Linux host.


#### SSH in Linux

For computer with Linux system, SSH can provides both graphic and non-graphic support to access the Linux server remotely. The ssh format of `ssh` goes as follows.

```bash
ssh [option] username@host_ip_address
```

For example,

```bash
ssh foo@x.x.x.x	 	# access user account foo with CLI only
ssh -X foo@x.x.x.x 	# access user account foo by enabling graphic interfaces.
```

`ssh -X` means enableing `X11` forwarding. `X11` is a window system for bitmap displays, and it provides a framework for a GUI environment. Take MATLAB for example. we cannot visualize MATLAB graphic interface if we do not include `-X` option. However, the graphic interface is available if we include `-X`.

After the login, we can use command line to start a application. 


#### SSH in MacOS

SSH for non-graphic applications for MacOS is the same as above because MacOS is a Unix-like OS. However,  MacOS native applications do not use the X protocol for the rendering, but the Mac specific protocol. So we cannot use ssh X protocol forwarding as we could with a Linux server. To enable graphic application, we need to install an X server on MacOS and have the Linux program appear on Mac. 

[*XQuartz*](https://www.xquartz.org/) is the most common X server implementation for MacOS and it is free. The following websites and video gives a good tutorial for *XQuartz* installation:

- [Instructions to Connect to a Remote Linux Server and Open a Graphical Program](https://princetonuniversity.github.io/PUbootcamp/ssh-instructions/)
- [Installing or Reinstalling XQuartz](https://www.l3harrisgeospatial.com/Support/Self-Help-Tools/Help-Articles/Help-Articles-Detail/ArtMID/10220/ArticleID/23855/Installing-or-Reinstalling-XQuartz-if-Upgrade-to-macOS-1015-Catalina-Causes-Issues)
- [Connect to Graphical Applications on Linux using XQuartz on a Mac](https://www.youtube.com/watch?v=s6e3cqCISaE)


#### SSH in Windows
Windows uses other network protocals rather than SSH for remote access. Therefore, we need to install both SSH client software and an X server to enable graphic application in the Linux host. 

[PuTTY](https://www.putty.org/) is the most common SSH client software for Windows. Follow the instructions in the website to install PuTTY.

There are many X servers for Windows, for example, [Xming](http://www.straightrunning.com/XmingNotes/), [VcXsrv](https://sourceforge.net/projects/vcxsrv/). See [X servers for Windows](https://teamdynamix.umich.edu/TDClient/47/LSAPortal/KB/ArticleDet?ID=1797) for a complete review.

It is recommended to use [MobaXterm](https://mobaxterm.mobatek.net/), which contains both SSH client and X server. It is free and the UI is also friendly.

**Note:** The latest builds of Windows 10 and Windows 11 include a built-in SSH server and client that are based on OpenSSH, a connectivity tool for remote sign-in that uses the SSH protocol. Therefore, basic SSH operations with command line can be performed without installing SSH software.  



### Graphic Interface in Modern Software

When using `ssh -X`, the server reder the display information and send back to the client. The client will interprete the display information and display to the user. This process is generic and can be applied to any software with graphic interface. However, the access process can be slow because of huge amount of display information. 

In practice, many softwares do not need to enable `-X` option to have graphic interface. They only require the server and software to have the same software. The server runs the software and send the computation back only. The client software receive the computation results and display the result to the user directly. No additional display information needs to be transmitted. The following figure shows two different modes. 

![img](../_media/ssh_graphics.png)

Many software such as *VS code* and *PyCharm* all follow the same pattern. SSH configurations of these softwares are discussed in [Installed Software](_pages/installed_software.md)

(to be updated...)


#### Interpretation of `-X` Parameter

(to be updated...)



#### Remote Access via VNC

Virtual Network Computing (VNC) is a graphical desktop-sharing system that uses the Remote Frame Buffer protocol (RFB) to remotely control another computer. 

(to be updated...)



