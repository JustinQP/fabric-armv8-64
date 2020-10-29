#!/bin/bash
# default image tag
IMAGETAG="latest"
COMPOSE_FILE="docker-compose-cli.yaml"
COMPOSE_COUNCH_FILE=docker-compose-couch.yaml

# Print the usage message
function printHelp() {
  echo "Usage: "
  echo "  byfn.sh <mode>"
  echo "    <mode> - one of 'up', 'down'"
  echo "      - 'up' - bring up the network with docker-compose up"
  echo "      - 'down' - clear the network with docker-compose down"
  echo
  echo "Taking all defaults:"
  echo "	byfn.sh up"
  echo "	byfn.sh down"
}

function channelUp() {

  COMPOSE_FILES="-f ${COMPOSE_FILE} -f ${COMPOSE_COUNCH_FILE}"
  
  IMAGE_TAG=$IMAGETAG docker-compose $COMPOSE_FILES up -d 2>&1
  docker ps -a
  if [ $? -ne 0 ]; then
    echo "ERROR !!!! Unable to start network"
    exit 1
  fi
  
  #docker cp /usr/local/fabric/gopath/src/github.com/hyperledger/fabric-peer-org2/mychannel.block  cli:/opt/gopath/src/github.com/hyperledger/fabric/peer/
  # now run the end to end script
  #docker exec cli scripts/script.sh
  #if [ $? -ne 0 ]; then
  #  echo "ERROR !!!! Test failed"
  #  exit 1
  #fi
}
function channelDown() {
	  docker-compose -f $COMPOSE_FILE down --volumes --remove-orphans
	  rm -rf channel-artifacts
	  rm -rf crypto-config
	  rm -rf mychannel.block
}
 

  
MODE=$1 
#Create the network using docker compose
if [ "${MODE}" == "up" ]; then
  channelUp
elif [ "${MODE}" == "down" ]; then ## Clear the network
  channelDown
else
  printHelp
  exit 1
fi