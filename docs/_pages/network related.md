## IP address related

In the IP protocol, each device on a network has a **unique identifier** that is called IP address. IPv4 addresses are divided into two categories:

- Public address
- Private address

If not specific mentioned, we are discussing IPv4.



### Public IP vs private IP

The public address is also known as an *external address*. This address is used to access the internet. This address is generally assigned by the ISP. A public IP address is **globally unique**, and can **only** be assigned to a **unique device**.

Key points related to public address are:

- The scope of the public address is global, which means that we can communicate outside the network.
- This address is assigned by the ISP (Internet Service Provider).
- It is not available at free of cost.
- We can get the Public IP by typing on Google "What is my IP".



The private address is also known as an *internal address*. It is used to communicate within the network. These addresses are not routed on the internet so that **no traffic can come from the internet to this private address**. When a computer is assigned a private IP address, the local devices see this computer via it's private IP address. However, the devices residing outside of your local network cannot directly communicate via the private IP address, but uses your router's public IP address to communicate. To allow direct access to a local device which is assigned a private IP address, a Network Address Translator (NAT) should be used.

There are three IP blocks (class A, class B and class C) reserved for a private use:

| Class | Starting IP Address | Ending IP Address | # of Hosts |
| :---: | :------------------ | :---------------- | :--------- |
|   A   | 10.0.0.0            | 10.255.255.255    | 16,777,216 |
|   B   | 172.16.0.0          | 172.31.255.255    | 1,048,576  |
|   C   | 192.168.0.0         | 192.168.255.255   | 65,536     |

**Key points related to private address are:**

- Its scope is local, as we can communicate within the network only.
- It is generally used for creating a local area network.
- It is available at free of cost.
- We can get to know the private IP address by simply typing the "ipconfig" on the command prompt.



### IP address of the Router

In this section, we resolve two comon novice questions:

- Why do other people have same IP address with me?
- Why all routers have the same IP address and they all starts from xxx.xxx.xxx.1?

For the first question, it is clear if we figure out the concepts of public/private IP address. To be short. If A and B have "same" IP addresses, they actually have same priviate IP addresses. But these private IP addresses are assinged in different local networks. A and B cannot visit each other unless they know the public IP address of their local network router. See this blog for details: [Why do other people have the same IP address as me?](https://pc.net/helpcenter/answers/sharing_the_same_ip_address#:~:text=This%20IP%20address%20is%20provided,the%20same%20external%20IP%20address.)



The second question. The router is responsible for assigning priviate IP addresses to different devices. When we use the Internet, our priviate IP address is hidden and only your **public IP address** is seen by other computers on the Internet. This IP address is provided by your ISP and is assigned to the device that your modem is connected to, **which is typically our router**.

We can check our priviate IP address from the computer. For example, in Mac, our priviate IP is 10.0.1.50.

![image](https://hellotechguide.wpengine.com/wp-content/uploads/2019/10/mac-router-ip-address-advanced-network-system-preferences.jpg)

But what is the router's IP address in the following? Why the router has IP address 10.0.1.1? This is clearly not the public IP address!

![image](https://hellotechguide.wpengine.com/wp-content/uploads/2019/10/tcip-mac-router-ip-address.jpg)

It turns out that this IP address 10.0.1.1 is priviate IP address for the router. Each router is responsible for setting up a local network and assigning priviate IP. Usually, the first priviate IP address (10.0.1.1 in this example) is reserved for the router. Other devices can utilize the rest, for example, the computer in the figure uses 10.0.1.50. 

But router usually has the public IP address. How to check that? The answer is Google. We can obtain out public IP address by **searching online**.



### How the IP address are assigned and managed

The IP address are managed and assigned in a herachical way. INAN (internet assinged number authority) manages the IP address globally. INAN assigns different group of IP address to regional registries. There are five regional registries in total: AFRINIC, APNIC, ARIN, LACNIC, PIRE NCC.

![image-20210103001132386](/Users/yuhan/Library/Application Support/typora-user-images/image-20210103001132386.png)

There are also sub registries such as APJII:

![image](https://bearsmyip.com/images/ip-assigned-chart.png)

The internet service provider (ISP) then obtain IP adress from local registries and assign to users. The hierachy goes as follows.

- INAN
  - AFRINIC
  - APNIC 
    - APJII
    - CNNIC
      - Local ISP
        - Local users
  - ARIN
  - LACNIC
  - PIRE NCC

**Note:** Above IP address are **public IP address**. For IPv4, we have priviate IP address, which is related to the router and LAN. Usually, we have routers to expand the size of local users.

For example, if you have **multiple computers** within your home you may want to use private IP addresses to address each computer within your home. In this scenario, your **router gets the public IP address**, and **each of the computers, tablets and smartphones connected to your router (via wired or wifi) gets a private IP address** from your router via [DHCP](https://www.iplocation.net/dhcp) protocol.

To be short, our computers usually do not access internet directly. They access a machine from ISP and the machine access internet directly. The public IP is for the machine of ISP, and the private IP is for our self. We can think that the ISP machine form a local network and our computers are nodes.

See the following: 

- [What is the difference between public and private IP address?](https://www.iplocation.net/public-vs-private-ip-address#)
- [Difference between Private and Public IP addresses](https://www.tutorialspoint.com/difference-between-private-and-public-ip-addresses#:~:text=Private%20IP%20Address%20and%20Public,by%20ISP%2C%20Internet%20Service%20Provider.)



### Difference between router and modem

These two are common peripherals, and their functions are actually easy to ditinguish and understand.

![image](https://hellotechguide.wpengine.com/wp-content/uploads/2019/10/router-ip-address.jpg) 

- The router is responsible for establishing local networks and assign priviate IP address.
- The modem provides access to the Internet. 

Connecting to a router provides access to a local network (LAN), but it does not necessarily provide access to the Internet.  In order for devices on the network to connect to the Internet, the router must be connected to a modem. The figure shows the relation between a modem and router.

In most cases, your **router will take a (mostly) static public IP address from your modem and transform it into a dynamic private IP address**. This allows you to buy new devices and connect them to your WiFi without having to set a new IP address for every device.





## Static IP vs Dynamic IP

Static/dynamic IP refers to the life cycle of an IP address (both public and priviate IP address). So it describes a different aspect of IP address compared with public/private IP. See this: [Static and dynamic IP address](https://www.iplocation.net/static-vs-dynamic-ip-address)

The static IP is easy to understand: the IP does not change after the assignment. The device with assigned IP address will use this address all the time. Static IP addresses typically have two versions: IPv4 and IPv6. In static IP addressing, each device on the network has its own address with no overlap and we have to configure the static IP addresses manually. 

The dynamic IP means that the IP address assigned for a device may change after a period of time. The address has to be **renewed** after some period of time. How the dynamic IP is assigned and renewed is perform by DHCP.

The reason we need dynamic IP is that it can be inefficient for some devices to occupy the same IP address all the time. When the device is idel, its IP address can be used for other devices to access the network. So we only need to assign an IP when the device is awake without hurting its requirement too access the network. 



### DHCP introduction

DHCP (Dynamic Host Configuration Protocol) is a protocol for assigning dynamic IP addresses to devices that are connected to the network. It consists of two components.

- A DHCP client
- A DHCP server

#### DHCP Server

A DHCP server is responsible for **allocating IP address** and other information to requesting clients. To create dynamic IP addresses, the network **must** have a DHCP server configured and operating.

IP addresses from a DHCP server are normally **leased**, and must be **renewed** periodically. The renewal process is automatic. 

#### DHCP Client

 A DHCP client is responsible for **requesting an address and assigning it to the computer**. All modern operating systems come equipped with a DHCP client and by default, they are all configured to use DHCP. 

We can manually configure DHCP client program so that we can be assigned an IP address within a specific range. We can also disable DHCP and ask the router to assign a static IP address.



### Where is DHCP server and client

First, it is clear that each computer has a DHCP client, so that it can require dynamic IP address. Each router has a DHCP server, so that it can assign dynamic IP address to different devices according to request.

But we should also note that **the router also has DHCP client**. The router's DHCP server is for the local network and its devices, while the router's DHCP client is for the ISP hub. To distinguish, we say a router has a **LAN-facing DHCP server** and a **WAN-facing DHCP client**.

The router obtains the public IP address from the ISP, ie, DHCP to the modem. But this IP address doesn't have to be static, it can be dynamic. It is actually rare for our router to set to a static address although it can be. So the public IP address can periodically change (or unchanged after renewal). In our home wifi, when we check the public IP address in different time, it may be dirrernt. Check this forum: [Is DHCP address assigned to the router or the computer?](https://www.quora.com/Is-DHCP-address-assigned-to-the-router-or-the-computer)



### Comparision between dynamic IP and static IP

Tt is undoubtedly that DHCP is the more popular option for most users as they are easier and cheaper to deploy. The following blog lists the advantages and disadvantages of two: [DHCP vs Static IP: Which One Is Better?](https://community.fs.com/blog/dhcp-vs-static-ip-differences.html#:~:text=Static%20IP%20addresses%20allow%20network,using%20that%20IP%20address%20again.&text=While%20DHCP%20is%20a%20protocol,task%20of%20assigning%20IP%20addresses.)





## DNS related

The Domain Name System (DNS) is a decentralized naming schema of resolving domain (host) names into numerical IP Addresses. 

The DNS is equivalent to a telephone directory where you would look up a person's telephone number by their name.



- DNS is a client/server network communication protocol. DNS clients send requests to the. server while DNS servers send responses to the client.
- Client requests contain a name which is converted into an IP address known as a **forward DNS lookups** while requests containing an IP address which is converted into a name known as **reverse DNS lookups**.



### Structure and functions

See this blog for detail: [What is the DNS?](https://www.iplocation.net/dns#)

When you type a domain name into a web browser (i.e. iplocation.net), your device searches its **local DNS Cache** to find an IP Address of the domain name. If the local DNS does not have the IP Address of the hostname you're requesting, it sends the query to the **DNS servers your device knows about**. These servers are usually dependent on which ISP you're currently using and their only function is to answer queries for IP Addresses. Once the hostname is found and the query is resolved, the DNS servers will keep a history of the lookup and store them in its cache for future lookups. If the DNS server can't resolve the IP Address of the domain name, it **recursively** sends the query to **upper DNS server** until it reaches the **root name server**. The root name server reads the hostname extension first (in our scenario, it would be “.net” of iplocation.net) and sends the query to the **Top Level Domain (TLD) name server**. The TLD name server would identify which **authoritative name server** to forward the query based on the extension of the domain name after reading the second-level domain name ("iplocation"). As the authoritative name server contains all the information about the relevant extension, it would then be able to find the IP Address of the query and then pass it down the chain to the device which made the query. This is how the IP addresses are retrieved from local DNS cache level to the extended authoritative DNS servers.

![image](/Users/yuhan/Documents/Picture1.png)



[What is DNS and how does it work?](https://www.networkworld.com/article/3268449/what-is-dns-and-how-does-it-work.html)

[DHCP and DNS: What Are They, What’s Their Difference?](https://community.fs.com/blog/dhcp-and-dns-difference.html)





### Gateway

A gateway is a [hardware](https://techterms.com/definition/hardware) device that acts as a "gate" between two [networks](https://techterms.com/definition/network). It may be a [router](https://techterms.com/definition/router), [firewall](https://techterms.com/definition/firewall), [server](https://techterms.com/definition/server), or other device that enables traffic to flow in and out of the network.

While a gateway protects the [nodes](https://techterms.com/definition/node) within network, it also a node itself.

- A router is a common type of gateway used in home networks. It allows computers within the local network to send and receive data over the [Internet](https://techterms.com/definition/internet). 
- A firewall is a more advanced type of gateway, which filters inbound and outbound traffic, disallowing incoming data from suspicious or unauthorized sources. 
- A [proxy server](https://techterms.com/definition/proxyserver) is another type of gateway that uses a combination of hardware and software to filter traffic between two networks. 