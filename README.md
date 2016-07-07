# chat-api

### Requirements
  * Ruby 2.3.1
  * Rails 5.0.0.rc2
  * Redis 3.2.1
  * PostgreSQL 9.5.2

### Deploy
  * configure db in config/database.yml
  * configure redis in config/initializers/redis.rb
  * rails db:create
  * rails db:migrate


### Location
  Deployed at https://mls-chat-api.herokuapp.com/

### Usage
  User registration:
  curl -X POST -d "user[username]=user&user[password]=test" https://mls-chat-api.herokuapp.com/users

  User auth:
  curl -X POST -d "user[username]=user&user[password]=test" https://mls-chat-api.herokuapp.com/sessions

  Users list:
  curl -X GET -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/users

  User info:
  curl -X GET -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/users/1

  Chat creating:
  curl -X POST -d "chat[name]=first chat&chat[user_ids][]=2" -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/chats

  Chat editing:
  curl -X PATCH -d "chat[name]=first chat new&chat[user_ids][]=3" -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/chats/4

  Get user's chats list
  curl -X GET -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/chats

  Send message to chat
  curl -X POST -d "message[content]=some message text" -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/chats/4/messages

  Mark chat as read
  curl -X PATCH -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/chats/4/read

  Get list new messages
  GET -H "Authorization: Token token=7bec359c82b616c7560ee33892cfcdf1" https://mls-chat-api.herokuapp.com/chats/4/messages/new

  ### Author
  Kotsiuruba Ruslan
