# Build stage
FROM golang:1.21-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o bluengo

# Final stage
FROM alpine:3.19
RUN adduser -D bluengo
USER bluengo
WORKDIR /app
COPY --from=builder /app/bluengo .
EXPOSE 8080
ENTRYPOINT ["./bluengo"]
CMD ["server", "-port", "8080"]























