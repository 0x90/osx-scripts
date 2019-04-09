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
#minikube start


brew cask install osxfuse
brew install datawire/blackbird/telepresence

# ODO
sudo curl -L https://github.com/redhat-developer/odo/releases/download/v0.0.20/odo-darwin-amd64 -o /usr/local/bin/odo && sudo chmod +x /usr/local/bin/odo

brew update
brew install jq graphviz awscli gettext coreutils
brew link --force gettext

brew cask install osxfuse
brew install datawire/blackbird/telepresence

# RANCHER
brew install rancher-cli

helm repo add istio.io "https://gcsweb.istio.io/gcs/istio-prerelease/daily-build/release-1.1-latest-daily/charts/"

helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/

curl -sS https://get.fabric8.io/download.txt | bash



