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
    && cargo install oha \ 
    # https://github.com/dalance/procs
    && cargo install procs
RUN ls -l /usr/local/cargo/bin


FROM debian:bookworm-slim
RUN apt-get update \ 
    && apt-get install -y --no-install-recommends \
    curl \ 
    tcpdump \ 
    inetutils-telnet \
    netcat \
    procps \
    net-tools \ 
    bind9-dnsutils \
    iperf3 \
    vim \
    jq \
    yq \
    bash \
    bash-completion \
    # https://github.com/sharkdp/hyperfine
    && apt-get install -y --no-install-recommends hyperfine \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir /app
COPY --from=go-builder /go/bin/tcping /app/tcping
COPY --from=go-builder /go/bin/plow /app/plow
COPY --from=rust-builder /usr/local/cargo/bin/trip /app/trip
COPY --from=rust-builder /usr/local/cargo/bin/btm /app/btm
COPY --from=rust-builder /usr/local/cargo/bin/rustscan /app/rustscan
COPY --from=rust-builder /usr/local/cargo/bin/oha /app/oha
COPY --from=rust-builder /usr/local/cargo/bin/procs /app/procs
ENV PATH="/app:${PATH}"

CMD [ "/bin/bash" ]

