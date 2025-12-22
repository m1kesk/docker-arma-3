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
RUN apt-get update
RUN apt-get autoremove -y
RUN apt-get clean -y

# set steam app
RUN steamcmd +login anonymous +quit
RUN echo $APP_ID > steam_appid.txt

# create folders
# RUN mkdir -p /home/steam/arma3

# install server
RUN mkdir -p $INSTALL_DIR
RUN steamcmd +force_install_dir $INSTALL_DIR +login anonymous +app_update $APP_ID validate +quit
# RUN steamcmd +force_install_dir $INSTALL_DIR +login $STEAM_USER $STEAM_PASS +app_update $APP_ID validate +quit

# set working directory
WORKDIR $INSTALL_DIR

# set entrypoint
ENTRYPOINT ["./arma3server_x64", "-profiles=/profiles"]
