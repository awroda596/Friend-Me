FROM ghcr.io/cirruslabs/flutter:3.20.0-1.1.pre
RUN apt update
RUN apt install cmake -y
RUN apt install clang -y
RUN apt install ninja-build -y
RUN apt install pkg-config -y
RUN apt install libgtk-3-dev -y
##chrome install, disabled for now for ease of use 
#RUN wget https://dl-ssl.google.com/linux/linux_signing_key.pub -O /tmp/google.pub
#RUN apt install gpg-agent -y
#RUN gpg --no-default-keyring --keyring /etc/apt/keyrings/google-chrome.gpg --import /tmp/google.pub
#RUN echo 'deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
#RUN apt-get update
#RUN apt-get install google-chrome-stable -y
RUN flutter doctor
RUN apt install -y xauth
RUN touch /.Xauthority
RUN touch /root/.Xauthority
RUN xauth add <token> #<--- replace with token or remove on WSL
RUN adduser --system --group chrome
RUN mkdir /app/
COPY ./friend_me /app/
WORKDIR /app/
CMD flutter run 
