# pod-debug



# use

```bash
# create test nginx pod
kubectl run nginx --image=nginx

# attach debug pod
kubectl debug -it nginx --image=docker.io/calacaly/pod-debug:master --target=nginx -- /bin/bash


```



# tools

## network

+ tcpdump

+ curl

+ iperf3

+ nc

+ telnet

+ dig

+ tcping [GitHub - pouriyajamshidi/tcping: Ping TCP ports using tcping. Inspired by Linux&#39;s ping utility. Written in Go](https://github.com/pouriyajamshidi/tcping)

+ trip [GitHub - fujiapple852/trippy: A network diagnostic tool](https://github.com/fujiapple852/trippy)

+ rustscan [GitHub - bee-san/RustScan: 🤖 The Modern Port Scanner 🤖](https://github.com/bee-san/RustScan)

+ plow [GitHub - six-ddc/plow: A high-performance HTTP benchmarking tool that includes a real-time web UI and terminal display](https://github.com/six-ddc/plow)

+ oha [GitHub - hatoo/oha: Ohayou(おはよう), HTTP load generator, inspired by rakyll/hey with tui animation.](https://github.com/hatoo/oha)

+ and more ...

## text

+ vim

+ awk

+ cat

+ grep

+ jq

+ yq

+ awk

## system

+ btm [GitHub - ClementTsang/bottom: Yet another cross-platform graphical process/system monitor.](https://github.com/ClementTsang/bottom)

+ procs [GitHub - dalance/procs: A modern replacement for ps written in Rust](https://github.com/dalance/procs)

+ hyperfine [GitHub - sharkdp/hyperfine: A command-line benchmarking tool](https://github.com/sharkdp/hyperfine)

+ ps 

+ top
