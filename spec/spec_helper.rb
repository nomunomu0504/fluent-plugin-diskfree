# テスト用に`fluent/test`を読み込む。
require "fluent/test"

# `RSpec`実行時に`Test::Unit`の自動実行結果が表示されてしまうので、自動実行されないようにする。
Test::Unit::AutoRunner.need_auto_run = false if defined? Test::Unit::AutoRunner

# テスト用のヘルパーを読み込む
require "fluent/test/helpers"

# フィルタプラグイン用のテストドライバを読み込む(フィルタプラグイン作成時)
require "fluent/test/driver/input"

# 開発するプラグインを読み込む
require "fluent/plugin/in_diskfree"

RSpec.configure do |config|
  # Fluent::Test.setupを呼び出しテスト用の初期化処理を行う
  config.before(:all) { Fluent::Test.setup }

  config.order = :random
end
