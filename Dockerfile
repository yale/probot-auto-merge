FROM node:alpine as builder

WORKDIR /app/auto-merge/

RUN apk add --no-cache --virtual .gyp python make g++

COPY ./package*.json ./

RUN npm install


FROM node:alpine as app

RUN apk --no-cache add git curl ca-certificates

WORKDIR /app/auto-merge/

COPY --from=builder /app/auto-merge/node_modules/ ./node_modules/
COPY . ./

RUN npm run build

EXPOSE 80

# Uncomment for running in dev
# COPY .env ./

CMD [ "npm", "start" ]
