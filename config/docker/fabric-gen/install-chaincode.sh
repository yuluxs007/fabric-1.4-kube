echo "Installing public chaincode on each peer"
CORE_PEER_ADDRESS=peer0-green-airline:7051  CORE_PEER_LOCALMSPID="green-airline"  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/green-airline/users/Admin@green-airline/msp   peer chaincode install -n bspcc -v 1.0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02
CORE_PEER_ADDRESS=peer0-green-agencies:7051 CORE_PEER_LOCALMSPID="green-agencies" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/green-agencies/users/Admin@green-agencies/msp peer chaincode install -n bspcc -v 1.0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02
CORE_PEER_ADDRESS=peer0-blue-airline:7051   CORE_PEER_LOCALMSPID="blue-airline"   CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/blue-airline/users/Admin@blue-airline/msp     peer chaincode install -n bspcc -v 1.0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02
CORE_PEER_ADDRESS=peer0-blue-agencies:7051  CORE_PEER_LOCALMSPID="blue-agencies"  CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/blue-agencies/users/Admin@blue-agencies/msp   peer chaincode install -n bspcc -v 1.0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02
CORE_PEER_ADDRESS=peer0-further:7051        CORE_PEER_LOCALMSPID="further"        CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp               peer chaincode install -n bspcc -v 1.0 -p github.com/hyperledger/fabric/examples/chaincode/go/chaincode_example02

echo "Initializing bsp chaincode for channel green. It is only done once by a single peer."
CORE_PEER_ADDRESS=peer0-further:7051 CORE_PEER_LOCALMSPID="further" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp CORE_PEER_CHAINCODELISTENADDRESS=peer0-further:8000 peer chaincode instantiate -o orderer-service:7050 -C green -n bspcc -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OutOf(2, 'further.member', 'green-airline.member', 'green-agencies.member')"

echo "Initializing bsp chaincode for channel blue. It is only done once by a single peer."
CORE_PEER_ADDRESS=peer0-further:7051 CORE_PEER_LOCALMSPID="further" CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/further/users/Admin@further/msp CORE_PEER_CHAINCODELISTENADDRESS=peer0-further:8000 peer chaincode instantiate -o orderer-service:7050 -C blue  -n bspcc -v 1.0 -c '{"Args":["init","a","100","b","200"]}' -P "OutOf(2, 'further.member', 'blue-airline.member', 'blue-agencies.member' )"