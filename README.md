# Study Environment for Elixir and Phoenix

elixirやphoenixについて勉強したり検証したりするための環境にしたいと思います。


## メモ

### configure database

config/dev.exsに記述  
プライマリキーをuuidにしたり、タイムスタンプの名前と型を変更したり。
これで、migrationした時にデータベースにお望みの設定がされる。
```
migration_primary_key: [id: :id, type: binary_id]
migration_timestamps: [inserted_at: :created_at, updated_at: modified_at, type: timestamptz]
```

### configure schema

全てのschema共通の設定をするschemaを作っておく。
```
defmodule StudyApp.Schema do
  defmacto __using__(_) do
    quote do
      use Ecto.Schema
      use Timex
      @primary_key {:id, :binary_id, autogenerate: true}
      @foreign_key_type :binary_id
      @timestamps_opts [inserted_at: :created_at, updated_at: :modified_at, type: :utc_datetime, autogenerate: {Timex, :now, ["UTC"]}]
    end
  end
end
```

これをそれぞれのschemaでuseしておくと、

- primary\_keyがuuidになる。しかもautogenerate
- 外部キー(user\_idとか)がuuidに対応(デフォルトは:id)
- timestamps()が上の設定のようになる。しかもautogenerate(ただ、createdとmodifiに若干ズレが生じる)

がアプリケーションレベルで実現できる。

### You shouldn't convert user input to atom.

atomはgarbage collectionされないらしい。ユーザー入力をアトムに変換していると、メモリがすぐ枯渇してしまいそう。
https://elixir-lang.org/getting-started/mix-otp/genserver.html

### link v.s. monitor

https://elixir-lang.org/getting-started/mix-otp/genserver.html#monitors-or-links

linkの場合は、繋がった二つのプロセスが同時に死ぬ。双方向。

monitorは一方通行。一方のプロセスのせいで他方のプロセスも死ぬことはない。
