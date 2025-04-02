FROM nginx:latest

# 健康チェック用HTMLの作成
RUN echo '<!DOCTYPE html>\n<html>\n<head>\n  <title>Health Check</title>\n</head>\n<body>\n  <h1>Health Check: OK</h1>\n  <p>Service is running properly.</p>\n  <p>Timestamp: ' $(date) '</p>\n</body>\n</html>' > /usr/share/nginx/html/healthcheck.html

# タイムスタンプを動的に更新するためのスクリプト
COPY healthcheck-update.sh /docker-entrypoint.d/
RUN chmod +x /docker-entrypoint.d/healthcheck-update.sh

# ポート80を公開
EXPOSE 80

# ヘルスチェックの設定
# HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost/healthcheck.html || exit 1

CMD ["nginx", "-g", "daemon off;"]
