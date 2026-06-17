#!/bin/bash
set -e
CONFIG="/home/work/.openclaw/openclaw.json"
PERSISTENT_CONFIG="/data/openclaw/openclaw.json"
if [ -f "$PERSISTENT_CONFIG" ]; then
  cp "$PERSISTENT_CONFIG" "$CONFIG"
else
  cat > "$CONFIG" << EOF
{
  "channels": {
    "qqbot": {
      "enabled": true,
      "appId": "${QQ_APP_ID}",
      "clientSecret": "***",
      "dmPolicy": "open",
      "groupPolicy": "open",
      "allowFrom": ["*"]
    }
  },
  "gateway": {
    "port": 7860,
    "bind": "lan",
    "auth": { "mode": "none" }
  }
}
EOF
  cp "$CONFIG" "$PERSISTENT_CONFIG"
fi
rm -rf /home/work/.openclaw/workspace
ln -sf /data/openclaw/workspace /home/work/.openclaw/workspace
mkdir -p /data/openclaw/workspace
exec openclaw gateway run --port 7860 --bind lan --force
