
openclaw channels login --channel feishu
# appId: cli_aa9afbf5efbadbdb  app_secret: o9ks2Ik46fYqrlPVWf8gUcDvolbFaRfd

openclaw config set channels.feishu.allowFrom '["ou_37171ab006b0c158e5d35ead7f987b89"]' --json

Get-NetTCPConnection -LocalPort 18789 | ForEach-Object { Stop-Process -Id $_.OwningProcess -Force }

Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"openclaw gateway run`"" -WindowStyle Hidden