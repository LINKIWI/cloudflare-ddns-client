install:
	sudo python3 -m pip install -r requirements.txt
	sudo cp cloudflare-ddns /usr/local/bin/cloudflare-ddns
	sudo chmod +x /usr/local/bin/cloudflare-ddns
