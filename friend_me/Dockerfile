FROM ghcr.io/cirruslabs/flutter:3.20.0-1.1.pre
RUN apt update
RUN apt install cmake -y
RUN apt install clang -y
RUN apt install ninja-build -y
RUN apt install pkg-config -y
RUN apt install libgtk-3-dev -y
RUN flutter doctor
RUN apt install -y xauth
run touch /.Xauthority
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
