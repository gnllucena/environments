kubectl create secret docker-registry \
	my-docker-registry \
	--namespace gocd \
	--docker-server=<docker_server_url> \
	--docker-username=<username> \
	--docker-password=<password> \
	--docker-email=<email>