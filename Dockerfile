# Use a base image that provides a complete Go build environment
FROM golang:1.17.8

# Copy in all the source code files
COPY . /go/src/outyet

# Set the working directory
WORKDIR /go/src/outyet

# Set a few environment variables for the build process
ENV CGO_ENABLED=0
ENV GOOS=linux

# Build the application. This will create the executable /go/src/outyet/outyet
RUN go get -v -d && \
    go install -v && \
    go test -v && \
    go build -ldflags "-s" -a -installsuffix cgo -o outyet .

# Define the port that the application binds to by default
EXPOSE 8080

# Define the command to run when the container is started
CMD ["/go/src/outyet/outyet", "-version", "1.17.8", "-poll", "600s", "-http", ":8080"]

