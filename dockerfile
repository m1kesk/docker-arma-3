FROM steamcmd/steamcmd

# set maintainer
LABEL maintainer="M1keSK <ing.michal.hudak@gmail.com>"

# set build arguments
ARG STEAM_USER='user'
ARG STEAM_PASS='pass'

# set environment variables
ENV APP_ID=233780
ENV INSTALL_DIR=/home/steam/arma3
ENV STEAM_USER=$STEAM_USER
ENV STEAM_PASS=$STEAM_PASS

# install dependencies
RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get install -y binutils

# set steam app
RUN steamcmd +login anonymous +quit
RUN echo $APP_ID > steam_appid.txt

# create folders
# RUN mkdir -p /home/steam/arma3

# install server
RUN mkdir -p $INSTALL_DIR
# RUN steamcmd +force_install_dir $INSTALL_DIR +login anonymous +app_update $APP_ID -beta public validate +quit
RUN steamcmd +force_install_dir $INSTALL_DIR +login $STEAM_USER $STEAM_PASS +app_update $APP_ID -beta creatordlc validate +quit

# set working directory
WORKDIR $INSTALL_DIR

# replace steamclient.so
RUN rm ./steamclient.so
RUN ln -s /root/.local/share/Steam/steamcmd/linux32/steamclient.so ./steamclient.so

# set entrypoint
ENTRYPOINT ["./arma3server_x64"]
