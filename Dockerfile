# Build Stage
FROM node:18-alpine AS builder

WORKDIR /app

#all two package files  package.json and package-lock.json copies
COPY package*.json ./

RUN npm ci

COPY . .

# Runtime Stage
FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=builder /app .

EXPOSE 3000

CMD ["npm", "start"]
