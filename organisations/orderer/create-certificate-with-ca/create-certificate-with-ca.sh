createCretificateForOrderer() {
  echo
  echo "Enroll the CA admin"
  echo
  mkdir -p ../crypto-config/ordererOrganizations/orderer.com

  export FABRIC_CA_CLIENT_HOME=${PWD}/../crypto-config/ordererOrganizations/orderer.com

  fabric-ca-client enroll -u https://admin:adminpw@localhost:5010 --caname ca-orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo 'NodeOUs:
  Enable: true
  ClientOUIdentifier:
    Certificate: cacerts/localhost-5010-ca-orderer.pem
    OrganizationalUnitIdentifier: client
  PeerOUIdentifier:
    Certificate: cacerts/localhost-5010-ca-orderer.pem
    OrganizationalUnitIdentifier: peer
  AdminOUIdentifier:
    Certificate: cacerts/localhost-5010-ca-orderer.pem
    OrganizationalUnitIdentifier: admin
  OrdererOUIdentifier:
    Certificate: cacerts/localhost-5010-ca-orderer.pem
    OrganizationalUnitIdentifier: orderer' >${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/config.yaml

  echo
  echo "Register orderer"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer2"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer2 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register orderer3"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer3 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem


  echo
  echo "Register orderer4"
  echo

  fabric-ca-client register --caname ca-orderer --id.name orderer4 --id.secret ordererpw --id.type orderer --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  echo
  echo "Register the orderer admin"
  echo

  fabric-ca-client register --caname ca-orderer --id.name ordererAdmin --id.secret ordererAdminpw --id.type admin --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/orderers
  # mkdir -p ../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.com

  # ---------------------------------------------------------------------------
  #  Orderer

  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com

  echo
  echo "## Generate the orderer msp"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp --csr.hosts orderer.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/config.yaml

  echo
  echo "## Generate the orderer-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls --enrollment.profile tls --csr.hosts orderer.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

  mkdir ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

  # -----------------------------------------------------------------------
  #  Orderer 2

  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com

  echo
  echo "## Generate the orderer2 msp"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp --csr.hosts orderer2.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp/config.yaml

  echo
  echo "## Generate the orderer2-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer2:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls --enrollment.profile tls --csr.hosts orderer2.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer2.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem

  # ---------------------------------------------------------------------------
  #  Orderer 3
  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com

  echo
  echo "## Generate the orderer3 msp"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp --csr.hosts orderer3.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp/config.yaml

  echo
  echo "## Generate the orderer3-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer3:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls --enrollment.profile tls --csr.hosts orderer3.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer3.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
  # ---------------------------------------------------------------------------

#  Orderer 4
  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com

  echo
  echo "## Generate the orderer4 msp"
  echo

  fabric-ca-client enroll -u https://orderer4:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/msp --csr.hosts orderer4.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/msp/config.yaml

  echo
  echo "## Generate the orderer4-tls certificates"
  echo

  fabric-ca-client enroll -u https://orderer4:ordererpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls --enrollment.profile tls --csr.hosts orderer4.orderer.com --csr.hosts localhost --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/ca.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/signcerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/server.crt
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/keystore/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/server.key

  mkdir ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/msp/tlscacerts
  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/tls/tlscacerts/* ${PWD}/../crypto-config/ordererOrganizations/orderer.com/orderers/orderer4.orderer.com/msp/tlscacerts/tlsca.orderer.com-cert.pem
  # ---------------------------------------------------------------------------

  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/users
  mkdir -p ../crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com

  echo
  echo "## Generate the admin msp"
  echo

  fabric-ca-client enroll -u https://ordererAdmin:ordererAdminpw@localhost:5010 --caname ca-orderer -M ${PWD}/../crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp --tls.certfiles ${PWD}/fabric-ca/ordererOrg/tls-cert.pem

  cp ${PWD}/../crypto-config/ordererOrganizations/orderer.com/msp/config.yaml ${PWD}/../crypto-config/ordererOrganizations/orderer.com/users/Admin@orderer.com/msp/config.yaml

}

createCretificateForOrderer