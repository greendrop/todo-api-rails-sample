# frozen_string_literal: true

module RoutesApi
  # extend された時、 draw のブロックを extend 元のスコープで実行する
  def self.extended(router)
    router.instance_exec(&@block) if @block
  end

  # ルーティングを登録する
  def self.draw(&block)
    @block = block
  end

  draw do
    namespace :v1 do
      # サインインユーザ
      get '/me' => 'users#me'

      namespace :users do
        resource :registration, only: %i[create update destroy]
      end

      # タスク
      resources :tasks, except: %i[new edit]
    end
  end
end
