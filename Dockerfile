FROM golang:alpine as go-builder
# https://github.com/pouriyajamshidi/tcping
RUN go install github.com/pouriyajamshidi/tcping/v2@latest \
    # https://github.com/six-ddc/plow
    && go install github.com/six-ddc/plow@latest
RUN ls -l /go/bin

FROM rust:slim-bullseye as rust-builder
RUN apt-get update && apt-get install -y libssl-dev pkg-config make cmake
# https://github.com/fujiapple852/trippy
RUN cargo install trippy \
    # https://github.com/ClementTsang/bottom
    && cargo install bottom \
    # https://github.com/bee-san/RustScan
    && cargo install rustscan \
    # https://github.com/hatoo/oha
    && cargo install oha
RUN ls -l /usr/local/cargo/bin


FROM alpine:latest
RUN apk add --no-cache --update curl tcpdump gcompat busybox-extras net-tools bind-tools iperf3 vim jq yq bash bash-completion \
    # https://github.com/sharkdp/hyperfine
    && apk add --no-cache --update hyperfine \
    # https://github.com/dalance/procs
    && apk add --no-cache --update procs \ 
    && mkdir /app
COPY --from=go-builder /go/bin/tcping /app/tcping
COPY --from=go-builder /go/bin/plow /app/plow
COPY --from=rust-builder /usr/local/cargo/bin/trip /app/trip
COPY --from=rust-builder /usr/local/cargo/bin/btm /app/btm
COPY --from=rust-builder /usr/local/cargo/bin/rustscan /app/rustscan
COPY --from=rust-builder /usr/local/cargo/bin/oha /app/oha
ENV PATH="/app:${PATH}"
RUN chmod +x /app/tcping \
    && chmod +x /app/plow \
    && chmod +x /app/trip \ 
    && chmod +x /app/btm \ 
    && chmod +x /app/rustscan \
    && chmod +x /app/oha

