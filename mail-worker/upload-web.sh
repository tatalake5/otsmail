#!/usr/bin/env bash
for f in $(find dist -type f ! -name index.html); do
  case "$f" in
    *.js) ct="application/javascript" ;;
    *.css) ct="text/css" ;;
    *.json) ct="application/json" ;;
    *.svg) ct="image/svg+xml" ;;
    *.png) ct="image/png" ;;
    *.jpg) ct="image/jpeg" ;;
    *.ico) ct="image/x-icon" ;;
    *.woff2) ct="font/woff2" ;;
    *.woff) ct="font/woff" ;;
    *) ct="application/octet-stream" ;;
  esac
  npx wrangler r2 object put "mail-r2/web/${f#dist/}" --file "$f" --content-type "$ct" --remote
done
npx wrangler r2 object put "mail-r2/web/index.html" --file "dist/index.html" --content-type "text/html" --remote
echo "upload done"
