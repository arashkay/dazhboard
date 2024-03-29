---
layout: post
title: Useful Commands for Linux Server Monitoring
category: Nginx
---
# Useful Commands for Linux Server Monitoring

## Disk Space Usage 

Run below command to see your local drives

```shell
df -kl
```

output is like:

```shell
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/xvda       98760300 5259008  92498404   6% /
tmpfs            2048368       0   2048368   0% /dev/shm
```

<div class='alert alert-info alert-tip'>
All the numbers are in kbyte, if you want in GB you can do <code>df -lBG</code>.
</div>

## Process Monitoring

`top` provides an ongoing look at processor activity in real time. It displays a listing of the most CPU-intensive tasks on the system.

Once you run `top` to watch the on going list, you can stop it by **Ctrl+c**.

You can use `top` for these reasons:

### Get current time, uptime, logged in users

```shell
top -bn1 | head -n1 | tail -1f
```

Output is like this:

```shell
top - 15:48:43 up 131 days,  3:13,  1 user,  load average: 0.00, 0.03, 0.05
```

- **current time**: 15:48:43
- **uptime of machine**: 131
- **logged in users**: 1

### Processes information

```shell
top -bn1 | head -n2 | tail -1f
```

Output is like this:

```shell
Tasks: 113 total,   1 running, 112 sleeping,   0 stopped,   0 zombie
```

- **Total processes**: 113
- **Running processes**: 1
- **Sleeping processes**: 112
- **Stopped processes**: 0
- **Zombie processes**: 0, Processes waiting for its parent process to read its exit status

### CPU usage

```shell
top -bn1 | head -n3 | tail -1f
```

Output is like this:

```shell
Cpu(s):  0.1%us,  0.2%sy,  0.0%ni, 99.6%id,  0.0%wa,  0.0%hi,  0.0%si,  0.0%st
```

- **User processes**: 0.1%us, this is the amount of actual CPU time spent in user-mode code (outside the kernel) within the process.
- **System processes**: 0.2%sy, it is the amount of CPU time spent in the kernel within the process (library code is part of user-mode).
- **Nice processes**: 0.0%ni
- **Not used percentage**: 99.6%id
- **Percentage of CPU processes waiting for IO processes**: 0.0%wa
- **Percentage of CPU served on hardware interrupts**: 0.0%hi, hardware interrupts are generated by hardware devices (network cards, keyboard controller, external timer, hardware senors, ...) when they need to signal something to the CPU (data has arrived for example).
- **Percentage of CPU served on software interrupts**: 0.0%si
- **Percentage of CPU stolen from virtual machine**: 0.0%st, it represents time when the real CPU was not available to the current virtual machine


### Top 5 processes by memory usage

```shell
top -bn1 -m | head -n12 | tail -7f
```

## Memory summary

```shell
free -m
```
**-m** will show all numbers in MB.

Output is like this:

```shell
             total   used   free  shared  buffers   cached
Mem:          4000   3370    629       0      242      280
-/+ buffers/cache:   2847   1152
Swap:          255      1    254
```

- **Total Memory**: 4000, memory/physical RAM available for your machine.
- **Used Memory**: 3370,  memory/physical RAM used by system. This include even buffers and cached data size as well.
- **Free Memory**: 629, Total free and available RAM for new process to run.
- **Shared Memory**: 0, it is obsolete and may be removed in future releases of free.
- **Buffered Memory**: 242, total RAM buffered by different applications in Linux
- **Cached Memory**: 280, total RAM used for caching of data for future purpose.
- **Actual Used Memory**: 2847, **Used Memory - (Buffered Memory+Cached Memory)**
- **Actual Total Available Memory**: 1152, **Total Memory - Actual Used Memory**
