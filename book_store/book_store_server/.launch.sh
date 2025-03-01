cd ../docker/development && docker compose up --build --detach 
cd ../../book_store_server && dart ./bin/main.dart --apply-migrations