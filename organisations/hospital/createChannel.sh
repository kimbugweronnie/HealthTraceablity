export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
export PEER0_ORG1_CA=${PWD}/crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=patientschannel

setGlobalsForPeer0Org1(){
    export CORE_PEER_LOCALMSPID="HospitalMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp
    export CORE_PEER_ADDRESS=localhost:10010
}

setGlobalsForPeer1Org1(){
    export CORE_PEER_LOCALMSPID="HospitalMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG1_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp
    export CORE_PEER_ADDRESS=localhost:10510
}

createChannel(){
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Org1
    
    # Replace localhost with your orderer's vm IP address
    peer channel create -o localhost:6010 -c $CHANNEL_NAME \
    --ordererTLSHostnameOverride orderer.orderer.com \
    -f ./../../artifacts/channel/${CHANNEL_NAME}.tx --outputBlock ./channel-artifacts/${CHANNEL_NAME}.block \
    --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
}

# createChannel

joinChannel(){
    setGlobalsForPeer0Org1
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
    setGlobalsForPeer1Org1
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block
    
}

# joinChannel

updateAnchorPeers(){
    setGlobalsForPeer0Org1
    # Replace localhost with your orderer's vm IP address
    peer channel update -o localhost:6010 --ordererTLSHostnameOverride orderer.orderer.com -c $CHANNEL_NAME -f ./../../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA
    
}

# updateAnchorPeers

# removeOldCrypto

createChannel
joinChannel
updateAnchorPeers