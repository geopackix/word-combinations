FROM node:12.18.1
ENV NODE_ENV=production

WORKDIR /app

COPY package*.json ./

RUN npm install

EXPOSE 3000

CMD [ "npm", "run", "start" ]