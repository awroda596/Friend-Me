FROM ghcr.io/cirruslabs/flutter:3.20.0-1.1.pre
RUN apt update
RUN apt install cmake -y
RUN apt install clang -y
RUN apt install ninja-build -y
RUN apt install pkg-config -y
RUN apt install libgtk-3-dev -y
RUN flutter doctor
RUN apt install -y xauth
# Rename the existing .Xauthority file by running the following command
# xauth with complain unless ~/.Xauthority exists
RUN touch ~/.Xauthority
# only this one key is needed for X11 over SSH 
# generate our own key, xauth requires 128 bit hex encoding)
#add host key???
RUN xauth add aroda-XPS-13-9305/unix:0  MIT-MAGIC-COOKIE-1  def30ba029b8086d4b7db738f741b886
# To view a listing of the .Xauthority file, enter the following 
RUN xauth list
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
CMD flutter run
