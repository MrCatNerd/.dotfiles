# NVIDIA THINGY

if nvidia container thingy keeps crashing after random periods:
`Failed to initialize NVML: Unknown Error` or smh like that
then in `/etc/nvidia-container-runtime/config.toml` change `no-cgroups` to:
```
no-cgroups = false
```

i havn't tested if it works yet so good luck lol
