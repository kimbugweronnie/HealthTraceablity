createcertificatesForOrg1() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/peerOrganizations/hospital.com/
  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/peerOrganizations/hospital.com/

  fabric-ca-client enroll -u https://admin:adminpw@localhost:1010 --caname ca.hospital.com --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-1010-ca-hospital-com.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-1010-ca-hospital-com.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-1010-ca-hospital-com.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-1010-ca-hospital-com.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/peerOrganizations/hospital.com/msp/config.yaml

  echo
  echo "Register peer0"
  echo
  fabric-ca-client register --caname ca.hospital.com --id.name peer0 --id.secret peer0pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  echo
  echo "Register peer1"
  echo
  fabric-ca-client register --caname ca.hospital.com --id.name peer1 --id.secret peer1pw --id.type peer --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  echo
  echo "Register user"
  echo
  fabric-ca-client register --caname ca.hospital.com --id.name user1 --id.secret user1pw --id.type client --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  echo
  echo "Register the org admin"
  echo
  fabric-ca-client register --caname ca.hospital.com --id.name org1admin --id.secret org1adminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/hospital.com/peers

  # -----------------------------------------------------------------------------------
  #  Peer 0
  mkdir -p ../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com

  echo
  echo "## Generate the peer0 msp"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:1010 --caname ca.hospital.com -M ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp --csr.hosts peer0.hospital.com --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp/config.yaml

  echo
  echo "## Generate the peer0-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer0:peer0pw@localhost:1010 --caname ca.hospital.com -M ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls --enrollment.profile tls --csr.hosts peer0.hospital.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/server.key

  mkdir ${PWD}/../crypto-config/peerOrganizations/hospital.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/msp/tlscacerts/ca.crt

  mkdir ${PWD}/../crypto-config/peerOrganizations/hospital.com/tlsca
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/tlsca/tlsca.hospital.com-cert.pem

  mkdir ${PWD}/../crypto-config/peerOrganizations/hospital.com/ca
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer0.hospital.com/msp/cacerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/ca/ca.hospital.com-cert.pem

  # ------------------------------------------------------------------------------------------------

  # Peer1

  mkdir -p ../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com

  echo
  echo "## Generate the peer1 msp"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:1010 --caname ca.hospital.com -M ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/msp --csr.hosts peer1.hospital.com --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/msp/config.yaml

  echo
  echo "## Generate the peer1-tls certificates"
  echo
  fabric-ca-client enroll -u https://peer1:peer1pw@localhost:1010 --caname ca.hospital.com -M ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls --enrollment.profile tls --csr.hosts peer1.hospital.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/tlscacerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/ca.crt
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/signcerts/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/server.crt
  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/keystore/* ${PWD}/../crypto-config/peerOrganizations/hospital.com/peers/peer1.hospital.com/tls/server.key

  # --------------------------------------------------------------------------------------------------

  mkdir -p ../crypto-config/peerOrganizations/hospital.com/users
  mkdir -p ../crypto-config/peerOrganizations/hospital.com/users/User1@hospital.com

  echo
  echo "## Generate the user msp"
  echo
  fabric-ca-client enroll -u https://user1:user1pw@localhost:1010 --caname ca.hospital.com -M ${PWD}/../crypto-config/peerOrganizations/hospital.com/users/User1@hospital.com/msp --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  mkdir -p ../crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com

  echo
  echo "## Generate the org admin msp"
  echo
  fabric-ca-client enroll -u https://org1admin:org1adminpw@localhost:1010 --caname ca.hospital.com -M ${PWD}/../crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp --tls.certfiles ${PWD}/fabric-ca/hospital/tls-cert.pem

  cp ${PWD}/../crypto-config/peerOrganizations/hospital.com/msp/config.yaml ${PWD}/../crypto-config/peerOrganizations/hospital.com/users/Admin@hospital.com/msp/config.yaml

}

createcertificatesForOrg1
