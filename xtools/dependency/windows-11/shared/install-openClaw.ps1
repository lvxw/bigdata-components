openclaw onboard --install-daemon
openclaw gateway stop
Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -Command `"openclaw gateway run`"" -WindowStyle Hidden