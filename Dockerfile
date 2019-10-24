# ---- Build Stage ----
FROM elixir:latest AS app_builder

# Set environment variables for building the application
ENV MIX_ENV=dev \
    TEST=1 \
    LANG=C.UTF-8

RUN apt-get update && \
  apt-get install -y postgresql-client
#RUN apk add --update git && \
#    rm -rf /var/cache/apk/*
# Create the application build directory
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Fetch the application dependencies and build the application
RUN mix deps.get
RUN mix do compile

RUN ls -ltR
# Run the Phoenix app
CMD ["./entrypoint.sh"]
