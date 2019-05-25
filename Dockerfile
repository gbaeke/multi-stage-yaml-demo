# argument for Go version
ARG GO_VERSION=1.12


# STAGE 1: building the executable
FROM golang:${GO_VERSION}-alpine AS build

# Working directory will be created if it does not exist
WORKDIR /src

# Import code
COPY ./ ./

# Build the executable
RUN CGO_ENABLED=0 go build \
	-installsuffix 'static' \
	-o /app .

# STAGE 2: build the container to run
FROM scratch AS final

# copy compiled app
COPY --from=build /app /app

# expose port 8080
EXPOSE 8080

# run binary
ENTRYPOINT ["/app"]

