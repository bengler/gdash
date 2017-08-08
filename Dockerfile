FROM eu.gcr.io/benglercloud/ruby:2.3

# Install gems (done separately to cache built gems)
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --deployment --without test:development

# Set up application
COPY . .
RUN mkdir templates \
  && chown -R app:app .

# Run application
EXPOSE 8080
ENTRYPOINT ["docker/entrypoint"]
CMD ["gosu", "app", "bundle", "exec", "unicorn", "-c", "config/unicorn.rb"]
