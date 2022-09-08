apt-get update

apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -p /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin


docker pull ipfs/kubo
mkdir ipfs
mkdir ipfs/staging
mkdir ipfs/data

echo docker run -d --name ipfs-base --restart always -v $(realpath ipfs/staging):/export -v $(realpath ipfs/data):/data/ipfs -p 4001:4001 -p 4001:4001/udp -p 8080:8080 -p 5001:5001 ipfs/kubo:latest daemon --migrate=true --agent-version-suffix=docker --enable-pubsub-experiment > start.sh

chmod +x start.sh
./start.sh


echo "Changing config (3 sec)..."
sleep 3
docker exec -ti ipfs-base ipfs config API.HTTPHeaders '{"Access-Control-Allow-Methods": ["PUT","GET","POST"], "Access-Control-Allow-Origin": ["*"]}' --json
docker exec -it ipfs-base ipfs config Gateway.APICommands '["/api/v0/pubsub/sub","pubsub/sub","/api/v0/pubsub/pub","pubsub/pub"]' --json
