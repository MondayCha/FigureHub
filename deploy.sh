pumactl stop -P ./figurehub_backend/tmp/pids/server.pid || true
git pull
# build vue project
cd figurehub_frontend
npm run build
# update rails public for vue
cd ../figurehub_backend
rm -rf ./public/favicon.ico
rm -rf ./public/index.html
rm -rf ./public/static
mv ../figurehub_frontend/dist/* ./public
### clean rails image store
# rm -f ./public/asserts/avatars/*
### start rails server
# bundle install
# rails db:reset
# rails db:migrate
rails server -d -b 0.0.0.0 -p 5000
