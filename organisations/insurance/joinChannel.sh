export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
export PEER0_ORG2_CA=${PWD}/crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=patientschannel

setGlobalsForPeer0Org2() {
    export CORE_PEER_LOCALMSPID="InsuranceMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/insurance.com/users/Admin@insurance.com/msp
    export CORE_PEER_ADDRESS=localhost:11010

}

setGlobalsForPeer1Org2() {
    export CORE_PEER_LOCALMSPID="InsuranceMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG2_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/insurance.com/users/Admin@insurance.com/msp
    export CORE_PEER_ADDRESS=localhost:11510

}

fetchChannelBlock() {
    rm -rf ./channel-artifacts/*
    setGlobalsForPeer0Org2
    # Replace localhost with your orderer's vm IP address
    peer channel fetch 0 ./channel-artifacts/$CHANNEL_NAME.block -o localhost:6010 \
        --ordererTLSHostnameOverride orderer.orderer.com \
        -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
}

# fetchChannelBlock

joinChannel() {
    setGlobalsForPeer0Org2
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

    setGlobalsForPeer1Org2
    peer channel join -b ./channel-artifacts/$CHANNEL_NAME.block

}

# joinChannel

updateAnchorPeers() {
    setGlobalsForPeer0Org2
    # Replace localhost with your orderer's vm IP address
    peer channel update -o localhost:6010 --ordererTLSHostnameOverride orderer.orderer.com \
        -c $CHANNEL_NAME -f ./../../artifacts/channel/${CORE_PEER_LOCALMSPID}anchors.tx \
        --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA

}

# updateAnchorPeers

fetchChannelBlock
joinChannel
updateAnchorPeers
