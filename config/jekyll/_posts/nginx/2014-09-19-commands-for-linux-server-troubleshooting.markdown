---
layout: post
title: Commands for Linux Server Troubleshooting
category: Nginx
---
# Commands for Linux Server Troubleshooting

When there is a problem in a live server, you need to be quick and probably don't know where to start from. Here is a list of things you can do to find the problem (most common server problems) within less than 10 minutes.

## Basic Server Troubleshooting Knowledge

### How to watch result of a command continuously

Guess what? It's called `watch` command. It will run a linux command with intervals. For example to see your RAM details continuously, do this:

```shell
watch free
```

### Terminating a command

In order to terminate a command, press Ctrl+c.

## How to detect a problem in server

### Check servers basic health
Use `top` to assess the basic system health and check (CPU, Memory, Processes). Do:

```shell
top
``` 

As a result you can see:

* **Tasks**: how many processes and their states ...
* **Cpu(s)**: how much of cpu is assigned used by user, system ...
* **Mem**: memory (RAM) summary ...
* A list of processes sorted by CPU usage. You can change the sorting by **'<','>'** or **'o','O'**. In order to learn more you can press **'?'** to see more information or press **Ctrl+c** to exit.

*A good alternative to **top** is **htop**, an evolution of top with features really amazing.*

### Check memory summary
Use `free` to get valuable information on available RAM. Using `watch` you can monitor changes too:

```shell
watch -d free -m
```

This will show how much free RAM you have, and how much is buffered by applications or cached for future purpose.

### Check DISK IO
Use `iostat` to monitor sustem input/output total since it was booted

```shell
watch -d iostat
```

As a result you can see:

* **tps**: indicate the number of transfers per second
* **kB_read/s**: the amount of data read from the device per second
* **kB_wrtn/s**: the amount of data written to the device per second
* **kB_read**: The total number of blocks read.
* **kB_wrtn**: The total number of blocks written.

You can see IOs by each process with `iotop` command. In order to see only list of processes doing the actual read/write do this:

```shell
iotop --only
```

* **Total Read/Write**: first line shows total read and write per second
* Read/Write by each process
