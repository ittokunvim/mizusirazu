# MIZUSIRAZU.NET

* Ruby version: 3.0.2
* System dependencies: ???
* Configuration: ???
* Database creation: `rails db:migrate`
* Database initialization: `heroku pg:reset`
* How to run the test suite: `bundle exec guard`
* Services (job queues, cache servers, search engines, etc.): not yet
* Deployment instructions: none



## Before git commit

- `bundle exec rubocop`
- `bundle exec rspec`



## rubocop

1. `bundle exec rubocop --auto-gen-cofig`
2. delete list in `.rubocop_todo.yml`
3. `bundle exec rubocop`
4. file fixed
5. loop 2 -> 3 -> 4

- `buncle exec rubocop --auto-correct` is convenient (Don`t use too match)



## rspec

参考記事: https://qiita.com/jnchito/items/42193d066bd61c740612



## guard-rspec

```ruby
group :test do
	# only macOS
  gem 'terminal-notifier'
	gem 'terminal-notifier-guard'
end
```

`bundle exec guard`を実行し、ファイルを保存することで自動テスト＋デスクトップ通知が可能になる。(maxOS)



## user configuration

- admin
  - indexに移動が可能
  - 他のユーザを削除できる
  - 他のユーザの編集はできない
- user
  - indexに移動できない
  - 他のユーザを削除できない（自分自身のみ）
  - 自分のユーザのみ編集が可能

### User routing

- /
  - /signup (users#new)
  - /users (users#index)
    - /:id (users#show)
  - /settings (users#edit)
  - /login (userSession#new)

