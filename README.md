## Softwares
- openssl

- make
    sudo apt install make

- gradlew
    sudo apt install gradle

- minikube
    https://kubernetes.io/docs/tasks/tools/install-minikube/

- kubectl
    https://kubernetes.io/docs/tasks/tools/install-kubectl/

- virtualbox 
- docker server
    https://docs.docker.com/install/
    
    Windows:
        1. O WSL está rodando

        2. O docker está instalado na WSL:
            $ curl -fsSL get.docker.com -o get-docker.sh

            $ sh get-docker.sh

            $ sudo usermod -aG docker $USER

            $ sudo systemctl enable docker

            $ sudo systemctl start docker

        3. O .bashrc possui "export DOCKER_HOST=tcp://localhost:2375"

        4. O docker possui acesso a todos os drivers da máquina

        5. O daemon do Docker está sendo exposto na porta 2375 pelo Windows

    Macos:
        1. Tenha HD

    Linux:
        <3

## GoCD

