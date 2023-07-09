createcertificatesForOrg3() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/laboratory.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:3010 --caname ca.laboratory.com --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-3010-ca-laboratory-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-3010-ca-laboratory-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-3010-ca-laboratory-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-3010-ca-laboratory-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/laboratory.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.laboratory.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  echo
  echo "Register peer1"
  echo
  fabric-ca-client register --caname ca.laboratory.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.laboratory.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.laboratory.com --id.name org3admin --id.secret org3adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:3010 --caname ca.laboratory.com -M ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/msp --csr.hosts peer0.laboratory.com --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:3010 --caname ca.laboratory.com -M ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls --enrollment.profile tls --csr.hosts peer0.laboratory.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/laboratory.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/laboratory.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/tlsca/tlsca.laboratory.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/laboratory.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer0.laboratory.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/ca/ca.laboratory.com-cert.pem

  # ------------------------------------------------------------------------------------------------

  # Peer1

  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:3010 --caname ca.laboratory.com -M ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/msp --csr.hosts peer1.laboratory.com --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:3010 --caname ca.laboratory.com -M ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls --enrollment.profile tls --csr.hosts peer1.laboratory.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/laboratory.com/peers/peer1.laboratory.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/users
  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/users/User1@laboratory.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:3010 --caname ca.laboratory.com -M ${PWD}/../crypto-config/peerOrganizations/laboratory.com/users/User1@laboratory.com/msp --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/laboratory.com/users/Admin@laboratory.com

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://org3admin:org3adminpw@localhost:3010 --caname ca.laboratory.com -M ${PWD}/../crypto-config/peerOrganizations/laboratory.com/users/Admin@laboratory.com/msp --tls.certfiles ${PWD}/fabric-ca/laboratory/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/laboratory.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/laboratory.com/users/Admin@laboratory.com/msp/config.yaml

}

createcertificatesForOrg3

