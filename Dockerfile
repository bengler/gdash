FROM docker.bengler.no/app:16.04-node5.11-python3.5-ruby2.3
MAINTAINER Erik Grinaker <erik@bengler.no>

# Set up environment
RUN useradd -md /srv/gdash -s /bin/bash gdash
WORKDIR /srv/gdash

# Install gems (done separately to cache built gems)
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --deployment --without test:development

# Set up application
COPY . .
RUN chown gdash config && mkdir templates

# Run application
USER gdash
EXPOSE 8080
ENTRYPOINT ["./docker.sh"]
CMD ["bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
