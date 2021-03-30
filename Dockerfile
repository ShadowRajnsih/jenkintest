FROM ubuntu
WORKDIR /usr/src/app
COPY . .
RUN apt-get update
RUN apt-get install --fix-missing
RUN apt-get install psmisc -y
RUN apt-get install nodejs -y
RUN apt-get install npm -y
RUN npm install -g express
ENV PORT 5000
EXPOSE 5000
CMD ["node","index.js"]