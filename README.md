# crypto-staking-wallets

## Presentation

Here you will find script attempt to :

1 - build wallet docker headless images

2 - deploy them on host


## Requirements

- Ansible
- Docker


## Building (optional)

Only if you want to revuild images


## Running

```
./deploy.sh
```

Will run *run_playbook.yml* to deploy on hosts defined in *host* inventory file.

  - create local guest wallet data directory
  - check python docker is present
  - get wallet docker image ({{ wallet_image }})
  - start wallet
  - Config set staking mode
  - Allow RPC on wallet
  - get wallet public address

