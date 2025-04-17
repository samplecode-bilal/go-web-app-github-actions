# Start with a base image
FROM golang:1.21 as base

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN go build -o main .

# Final slim image
FROM gcr.io/distroless/base

COPY --from=base /app/main .

# Removed static copy because folder doesn't exist
# COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./main"]
