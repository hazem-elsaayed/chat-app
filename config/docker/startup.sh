
# Prepare DB (Migrate - If not? Create db & Migrate)
bash ./config/docker/prepare-db.sh

# Start Application
bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"