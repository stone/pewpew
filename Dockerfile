# Build
FROM golang:1.18-buster AS build
WORKDIR /go/pewpew
COPY . .

# Must build without cgo because libc is unavailable in runtime image
ENV CGO_ENABLED=0
RUN go build

# Run
FROM scratch

COPY --from=build /go/pewpew/pewpew /pewpew
ENTRYPOINT ["/pewpew"]
CMD ["help"]
