FROM beorc/ruby-dev

ENV USER apps
ENV APP app

ENV GEM_HOME /.gem
ENV PATH $GEM_HOME/bin:$PATH
ENV BUNDLE_APP_CONFIG $GEM_HOME

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev phantomjs

RUN gem update --system $RUBYGEMS_VERSION
RUN gem install bundler

ENV HOME /home/$USER
RUN adduser --disabled-password --gecos '' $USER

RUN mkdir $HOME/$APP
WORKDIR $HOME/$APP

RUN chown -R $USER:$USER /usr/local/lib/ruby/gems/$RUBY_MAJOR.0/doc

RUN adduser $USER root

USER $USER
