# Use an official Elixir runtime as a parent image
FROM elixir:latest

RUN apt-get update && \
  apt-get install -y postgresql-client

RUN adduser -D -h /home/app app

# Create app directory and copy the Elixir projects into it
#RUN mkdir /app
COPY . /home/app
WORKDIR /home/app

# Install hex package manager
RUN mix local.hex --force
RUN mix local.rebar --force

# Compile the project
RUN mix deps.get
RUN mix do compile
#RUN chown -R app: /home/app
USER app

CMD ["/app/entrypoint.sh"]
