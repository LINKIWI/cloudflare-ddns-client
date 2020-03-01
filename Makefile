install:
	sudo pip install -r requirements.txt
	sudo cp cloudflare-ddns /usr/local/bin/cloudflare-ddns
	sudo cp -r cloudflare_ddns_src /usr/local/bin/cloudflare_ddns_src
	sudo chmod +x /usr/local/bin/cloudflare-ddns
	sudo chmod +x /usr/local/bin/cloudflare_ddns_src
