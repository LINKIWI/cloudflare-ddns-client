## CloudFlare DDNS Client
A Linux client for servers hosting CloudFlare-managed domains behind a dynamic external IP address

This Python-based script interfaces with [CloudFlare's client API](https://api.cloudflare.com/) to automatically and periodically update A and AAAA records of your CloudFlare domains with your server's current external IP address. This is generally intended for users whose servers are on a residential ISP with no static IP address assignment.

### Installation
Installation is fairly straightforward. Note that you should install the script on the server whose external IP you want reflected in your domains' DNS records. It is assumed that the server has a Python interpreter already installed.
```bash
git clone https://github.com/LINKIWI/cloudflare-ddns-client.git
cd cloudflare-ddns-client
sudo make install
```
This will install necessary Python libraries and place a copy of the `cloudflare-ddns` executable in `/usr/local/bin`. You can verify access to the executable with `which cloudflare-ddns`.

### Configuration
**You must configure `cloudflare-ddns` before you can use it.**

After successfully installing, simply run
```bash
cloudflare-ddns --configure
```
You will be presented with an interactive prompt to enter in details about your CloudFlare email, API key, and domains to auto-update.

Depending on how your subdomain records are configured (such as wildcard addresses), you may need to make multiple domain entries to ensure they all update. Example: `domain.com,*.domain.com,subdomain.domain.com`
```
=============Configuring CloudFlare automatic DDNS update client=============
You may rerun this at any time with cloudflare-ddns --configure
Quit and cancel at any time with Ctrl-C

Enter the email address associated with your CloudFlare account.
Example: developer@kevinlin.info
Email: YOUR_EMAIL_HERE

Enter the API key associated with your CloudFlare account. You can find your API key at https://www.cloudflare.com/a/account/my-account
Example: 7d9dfl2fid74lsg50saa9j2dbqm67zn39v673
CloudFlare API key: YOUR_API_KEY_HERE

Enter the domains for which you would like to automatically update the DNS records, delimited by a single comma.
Example: kevinlin.info,cloudflaremanager.com
Comma-delimited domains: YOUR_DOMAINS_HERE

Configuration file written to /home/kiwi/.cloudflare-ddns successfully.
```
After configuration, you should verify that the script works before continuing:
```bash
cloudflare-ddns --update-now
```
At this point, you can either run the script manually every time you would like to update your DNS records, or you can add it to your `crontab` to have it automatically run periodically. For example, to have the script run at midnight every day:
```bash
crontab -e
```
Then add the entry
```
0 0 * * * /usr/local/bin/cloudflare-ddns --update-now
```

### Docker / Kubernetes
A Dockerfile is included. This is mostly useful for cases where you want to run cloudflare-ddns-client as a cronjob in Kubernetes

Configuration must be created before running in docker and provided either as a Kubernetes secret or mounted as a file into the container.

Usage in local docker
```
docker run -v /path/to/your/.cloudflare-ddns:/home/cloudflare-ddns-client/.cloudflare-ddns cloudflare-ddns-client:latest
```
