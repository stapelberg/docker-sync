all:

push:
	docker build -t=stapelberg/docker-sync . && docker push stapelberg/docker-sync
