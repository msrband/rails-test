FROM purplelabs/rails:latest

RUN apt-get update -qq && apt-get install -y curl --no-install-recommends \
  && curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
  && curl -sS https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >>  /etc/apt/sources.list.d/pgdg.list' \
  && apt-get update -qq \
  && apt-get install -y vim google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf \
      xvfb gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 \
      libdbus-1-3 libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 \
      libgtk-3-0 libnspr4 libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
      libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 \
      libxtst6 ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils \
      git postgresql-client-11 \
      --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*
RUN apt-get update -qq && apt-get install -y libsqlite3-dev

ENV EDITOR vim
ENV TZ Asia/Seoul
ENV LC_ALL C.UTF-8

# Rails app
ENV RAILS_APP /app
RUN mkdir -p $RAILS_APP
WORKDIR $RAILS_APP

COPY docker-entrypoint.sh /
COPY Gemfile /app
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
