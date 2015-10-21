FROM beorc/ruby

ENV USER apps
ENV APP app

ENV GEM_HOME /.gem
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_APP_CONFIG $GEM_HOME

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev phantomjs

COPY Gemfile /Gemfile
COPY Gemfile.lock /Gemfile.lock

RUN gem update --system $RUBYGEMS_VERSION
RUN bundle install --with development test
RUN apt-get purge -y --auto-remove build-essential

ENV HOME /home/$USER
RUN adduser --disabled-password --gecos '' $USER

RUN mkdir $HOME/$APP
ADD . $HOME/$APP
WORKDIR $HOME/$APP

RUN chown -R $USER:$USER $HOME
RUN chown -R $USER:$USER /usr/local/lib/ruby/gems/$RUBY_MAJOR.0/doc

RUN adduser $USER root

USER $USER

EXPOSE 3000/tcp

CMD rm -f tmp/pids/server.pid && bundle exec rails s -b 0.0.0.0
