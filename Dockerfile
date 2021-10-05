FROM golang:1.16


RUN apt-get update && apt-get install -y vim libltdl7 libpcsclite1

WORKDIR /go/src/app

COPY . .

RUN scripts/install_certs.sh

RUN scripts/copy_libs.sh

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/kalkancrypt/:/opt/kalkancrypt/lib/engines

RUN go mod download
RUN go build -o /kalkan cmd/cli/main.go 

CMD [ "/kalkan" ]