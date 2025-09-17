#!/bin/sh
set -e

# Start MongoDB in background
mongod --bind_ip_all --auth &

# Wait a few seconds for MongoDB to start
echo "Waiting for MongoDB to initialize..."
sleep 5

# Create admin user if not exists
mongo <<EOF
use admin
db.createUser({
  user: "$MONGO_USER",
  pwd: "$MONGO_PASSWORD",
  roles: [{ role: "root", db: "admin" }]
})
EOF

# Start Node.js app
node server.js
