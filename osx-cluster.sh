brew update
brew install xhyve
brew install docker-machine-driver-xhyve
brew install hyperkit
brew install docker-machine-driver-hyperkit

# docker-machine-driver-hyperkit need root owner and uid 
sudo chown root:wheel /usr/local/opt/docker-machine-driver-hyperkit/bin/docker-machine-driver-hyperkit
sudo chmod u+s /usr/local/opt/docker-machine-driver-hyperkit/bin/docker-machine-driver-hyperkit

minikube config set vm-driver hyperkit
# minikube start --memory=2048 --vm-driver=xhyve
minikube start
