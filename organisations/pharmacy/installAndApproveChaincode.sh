export CORE_PEER_TLS_ENABLED=true
export ORDERER_CA=${PWD}/../orderer/crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
export PEER0_ORG4_CA=${PWD}/crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/ca.crt
export FABRIC_CFG_PATH=${PWD}/../../artifacts/channel/config/

export CHANNEL_NAME=mychannel

setGlobalsForPeer0Org4() {
    export CORE_PEER_LOCALMSPID="PharmacyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp
    export CORE_PEER_ADDRESS=localhost:13010

}

setGlobalsForPeer0Org4() {
    export CORE_PEER_LOCALMSPID="PharmacyMSP"
    export CORE_PEER_TLS_ROOTCERT_FILE=$PEER0_ORG4_CA
    export CORE_PEER_MSPCONFIGPATH=${PWD}/crypto-config/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp
    export CORE_PEER_ADDRESS=localhost:13510

}

presetup() {
    echo Vendoring Go dependencies ...
    pushd ./../../artifacts/src/javascript
    npm install
    popd
    echo Finished node modules
}
# presetup

CHANNEL_NAME="patientschannel"
CC_RUNTIME_LANGUAGE="node"
VERSION="1"
CC_SRC_PATH="./../../artifacts/src/javascript"
CC_NAME="patientsv2"

packageChaincode() {
    rm -rf ${CC_NAME}.tar.gz
    setGlobalsForPeer0Org4
    peer lifecycle chaincode package ${CC_NAME}.tar.gz \
        --path ${CC_SRC_PATH} --lang ${CC_RUNTIME_LANGUAGE} \
        --label ${CC_NAME}_${VERSION}
    echo "===================== Chaincode is packaged on peer0.org3 ===================== "
}

# packageChaincode

installChaincode() {
    setGlobalsForPeer0Org4
    peer lifecycle chaincode install ${CC_NAME}.tar.gz
    echo "===================== Chaincode is installed on peer0.org2 ===================== "

}

installChaincode

queryInstalled() {
    setGlobalsForPeer0Org4
    peer lifecycle chaincode queryinstalled >&log.txt

    cat log.txt
    PACKAGE_ID=$(sed -n "/${CC_NAME}_${VERSION}/{s/^Package ID: //; s/, Label:.*$//; p;}" log.txt)
    echo PackageID is ${PACKAGE_ID}
    echo "===================== Query installed successful on peer0.org2 on channel ===================== "
}

queryInstalled

approveForMyOrg2() {
    setGlobalsForPeer0Org4

    # Replace localhost with your orderer's vm IP address
    peer lifecycle chaincode approveformyorg -o localhost:6010 \
        --ordererTLSHostnameOverride orderer.orderer.com --tls $CORE_PEER_TLS_ENABLED \
        --cafile $ORDERER_CA --channelID $CHANNEL_NAME --name ${CC_NAME} \
        --version ${VERSION} --init-required --package-id ${PACKAGE_ID} \
        --sequence ${VERSION}

    echo "===================== chaincode approved from org 2 ===================== "
}
# queryInstalled
# approveForMyOrg2

checkCommitReadyness() {

    setGlobalsForPeer0Org4
    peer lifecycle chaincode checkcommitreadiness --channelID $CHANNEL_NAME \
        --peerAddresses localhost:13010 --tlsRootCertFiles $PEER0_ORG4_CA \
        --name ${CC_NAME} --version ${VERSION} --sequence ${VERSION} --output json --init-required
    echo "===================== checking commit readyness from org 1 ===================== "
}

# checkCommitReadyness
