FROM beorc/ruby

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

VOLUME /usr/local/bundler/gems

EXPOSE 3000/tcp

CMD bundle exec rails s -b 0.0.0.0
