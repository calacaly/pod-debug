FROM golang:alpine as go-builder
# https://github.com/pouriyajamshidi/tcping
RUN go install github.com/pouriyajamshidi/tcping/v2@latest \
    && go install github.com/pouriyajamshidi/udping/v2@latest


FROM rust:slim-bullseye as rust-builder
# https://github.com/fujiapple852/trippy
RUN cargo install trippy \
    # https://github.com/ClementTsang/bottom
    && cargo install bottom  \
    # https://github.com/bee-san/RustScan
    && cargo install rustscan


FROM alpine:latest
RUN apk add --no-cache --update curl tcpdump busybox-extras net-tools bind-tools iperf3 vim jq yq bash bash-completion \
    # https://github.com/sharkdp/hyperfine
    && apk add --no-cache --update hyperfine \
    # https://github.com/dalance/procs
    && apk add --no-cache --update procs \ 
    && mkdir /app
COPY --from=go-builder /go/bin/tcping /app/tcping
COPY --from=rust-builder /root/.cargo/bin/trip /app/trip
COPY --from=rust-builder /root/.cargo/bin/btm /app/btm
ENV PATH="/app:${PATH}"
RUN chmod +x /app/trip \ 
    && chmod +x /app/btm \ 
    && chmod +x /app/tcping