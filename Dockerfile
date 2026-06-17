# Build Stage
FROM node:18-alpine AS builder

WORKDIR /app

#all two package files  package.json and package-lock.json copies
COPY package*.json ./

#RUN nmp ci we can use but below command gives faster install
RUN npm install

COPY . .

# Runtime Stage
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

#RUN nmp install we can use but below command gives faster install
RUN npm install --omit=dev

COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"]
