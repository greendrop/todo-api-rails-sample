# todo-api-rails-sample

Railsを使用したAPIのサンプルです。

## API
  - https://petstore.swagger.io/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fgreendrop%2Ftodo-api-rails-sample%2Fmaster%2Fdocs%2Fapi%2Fschema.yml

## セットアップ

```shell
$ git clone git@github.com:greendrop/todo-api-rails-sample.git
$ cd todo-api-rails-sample
$ vi .envrc
$ direnv allow
$ docker-compose pull
$ docker-compose build
$ docker-compose run --rm web bash
$ cp .env.example .env
$ bundle install
$ yarn install
$ rake db:create
$ rake db:migrate
$ exit
$ docker-compose up
```

### .envrc

```
export USER_ID=`id -u`
export GROUP_ID=`id -g`
```
