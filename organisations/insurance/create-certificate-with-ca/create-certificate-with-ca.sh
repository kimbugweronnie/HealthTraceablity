createCertificateForOrg2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/insurance.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/insurance.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:2010 --caname ca.insurance.com --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-2010-ca-insurance-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-2010-ca-insurance-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-2010-ca-insurance-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-2010-ca-insurance-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/insurance.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.insurance.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.insurance.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.insurance.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.insurance.com --id.name org2admin --id.secret org2adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/insurance.com/peers
  mkdir -p ../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:2010 --caname ca.insurance.com -M ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/msp --csr.hosts peer0.insurance.com --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:2010 --caname ca.insurance.com -M ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls --enrollment.profile tls --csr.hosts peer0.insurance.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/insurance.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/insurance.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/tlsca/tlsca.insurance.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/insurance.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer0.insurance.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/ca/ca.insurance.com-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:2010 --caname ca.insurance.com -M ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/msp --csr.hosts peer1.insurance.com --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:2010 --caname ca.insurance.com -M ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls --enrollment.profile tls --csr.hosts peer1.insurance.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/insurance.com/peers/peer1.insurance.com/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/insurance.com/users
  mkdir -p ../crypto-config/peerOrganizations/insurance.com/users/User1@insurance.com

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:2010 --caname ca.insurance.com -M ${PWD}/../crypto-config/peerOrganizations/insurance.com/users/User1@insurance.com/msp --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/insurance.com/users/Admin@insurance.com

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://org2admin:org2adminpw@localhost:2010 --caname ca.insurance.com -M ${PWD}/../crypto-config/peerOrganizations/insurance.com/users/Admin@insurance.com/msp --tls.certfiles ${PWD}/fabric-ca/insurance/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/insurance.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/insurance.com/users/Admin@insurance.com/msp/config.yaml

}

createCertificateForOrg2