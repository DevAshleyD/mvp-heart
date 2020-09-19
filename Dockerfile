FROM node:12.2-alpine as prod

WORKDIR /api/code

COPY package*.json ./
RUN npm install && npm cache clean --force

ENV PATH /api/code/node_modules/.bin:$PATH

COPY . .

CMD ["node", "./server/index.js"]

FROM node:12.2-alpine

WORKDIR /client/app
ENV PATH /client/app/node_modules/.bin:$PATH
COPY package*.json ./
RUN npm install && npm cache clean --force
RUN npm audit fix

COPY . .

CMD ["npm start"]


WORKDIR ./postgres/init.sql:/docker-entrypoint-initdb.d/init.sql
WORKDIR ./postgres/seed.sql:/docker-entrypoint-initdb.d/seed.sql

COPY . .




