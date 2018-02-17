```
Subject: Hetzner.de API implementation
From: Todd T. Fries <todd@fries.net>
To: anyone reading this
```

I looked at other Hetzner implementations and found them needing a lot of work.
So I have made one that makes sense to me.

This is a work in progress, not feature complete, reading info only for now.

For now, $HOME/.hcli.conf should contain:

```
	huser = username
	hpass = password
```

for the api user you've setup at hetzner's [robot](https://accounts.hetzner.com/login) web interface.

This was originally part of [hetznercli](https://github.com/toddfries/hetznercli), but
that project is about the cli app, and this project is about the API.  I exercise this
api either via the 'hcli' app there, or via 'mcli -p hetzner' in [multicli](https://github.com/toddfries/multicli).

If you find this useful and wish to donate, I accept donations:

- BTC: [1NcjNAP65YmDTDZs7k5JH2wWF2hY9j9F9w](bitcoin:1NcjNAP65YmDTDZs7k5JH2wWF2hY9j9F9w)

- DCR: [DsjZiZ8smCuhkDejkv2a13gq8K3GXR2SSfi](decred:DsjZiZ8smCuhkDejkv2a13gq8K3GXR2SSfi)
