#!/bin/bash

# 起動時と定期的に健康チェックページのタイムスタンプを更新する
update_healthcheck() {
  echo '<!DOCTYPE html>
<html>
<head>
  <title>Health Check</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 40px; line-height: 1.6; }
    h1 { color: #4CAF50; }
    .status { padding: 10px; background-color: #e8f5e9; border-radius: 5px; }
  </style>
</head>
<body>
  <h1>Health Check: OK</h1>
  <div class="status">
    <p>Service is running properly.</p>
    <p>Host: ws</p>
    <p>Timestamp: '"$(date)"'</p>
  </div>
</body>
</html>' > /usr/share/nginx/html/healthcheck.html
}

# 初回更新
update_healthcheck

# バックグラウンドで定期的に更新（60秒ごと）
while true; do
  sleep 60
  update_healthcheck
done &

# スクリプトを終了しない（Docker-entrypoint用）
exit 0
