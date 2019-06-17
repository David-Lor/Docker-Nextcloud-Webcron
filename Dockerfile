FROM alpine

# ENV variables
ENV URL null
ENV TIME 600
ARG USERNAME=user

# Install curl
RUN apk update && apk add --no-cache curl

# Add a no-root user and use it
RUN addgroup $USERNAME && adduser $USERNAME -D -G $USERNAME

#Copy the Entrypoint script to user home
WORKDIR /home/$USERNAME
COPY entrypoint.sh entrypoint_cp.sh

# Fix https://stackoverflow.com/a/5491763/11245195
RUN cat entrypoint_cp.sh | tr -d '\r' >> entrypoint.sh

# Change script propietary and make it executable
RUN rm entrypoint_cp.sh && chown $USERNAME entrypoint.sh
USER $USERNAME
RUN chmod u+x entrypoint.sh

# Execute the entrypoint
CMD ["sh", "entrypoint.sh"]
