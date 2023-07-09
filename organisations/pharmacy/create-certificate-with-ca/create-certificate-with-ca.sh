createCertificateForOrg2() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/pharmacy.com/

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/pharmacy.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:4010 --caname ca.pharmacy.com --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-4010-ca-pharmacy-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-4010-ca-pharmacy-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-4010-ca-pharmacy-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-4010-ca-pharmacy-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/pharmacy.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo

  fabric-ca-client register --caname ca.pharmacy.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  echo
  echo "Register peer1"
  echo

  fabric-ca-client register --caname ca.pharmacy.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  echo
  echo "Register user"
  echo

  fabric-ca-client register --caname ca.pharmacy.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  echo
  echo "Register the org admin"
  echo

  fabric-ca-client register --caname ca.pharmacy.com --id.name org4admin --id.secret org4adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/pharmacy.com/peers
  mkdir -p ../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com

  # --------------------------------------------------------------
  # Peer 0
  echo
  echo "## Generate the peer0 msp"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:4010 --caname ca.pharmacy.com -M ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/msp --csr.hosts peer0.pharmacy.com --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:4010 --caname ca.pharmacy.com -M ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls --enrollment.profile tls --csr.hosts peer0.pharmacy.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/tlsca/tlsca.pharmacy.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer0.pharmacy.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/ca/ca.pharmacy.com-cert.pem

  # --------------------------------------------------------------------------------
  #  Peer 1
  echo
  echo "## Generate the peer1 msp"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:4010 --caname ca.pharmacy.com -M ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/msp --csr.hosts peer1.pharmacy.com --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo

  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:4010 --caname ca.pharmacy.com -M ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls --enrollment.profile tls --csr.hosts peer1.pharmacy.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/peers/peer1.pharmacy.com/tls/server.key
  # -----------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/pharmacy.com/users
  mkdir -p ../crypto-config/peerOrganizations/pharmacy.com/users/User1@pharmacy.com

  echo
  echo "## Generate the user msp"
  echo

  fabric-ca-client enroll -u https://user1:user1pw@localhost:4010 --caname ca.pharmacy.com -M ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/users/User1@pharmacy.com/msp --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com

  echo
  echo "## Generate the org admin msp"
  echo

  fabric-ca-client enroll -u https://org4admin:org4adminpw@localhost:4010 --caname ca.pharmacy.com -M ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp --tls.certfiles ${PWD}/fabric-ca/pharmacy/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp/config.yaml

}

createCertificateForOrg2