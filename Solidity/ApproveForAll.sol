This is all that it requires, a few helper contracts (literally 3 lines of code), a proxy address from MainNet OS, and overriding the isApprovedForAll function 🙂

//Helper contracts to get the job done
contract OwnableDelegateProxy { }
contract ProxyRegistry {
    mapping(address => OwnableDelegateProxy) public proxies;
}

//proxy address of mainnet OS
 address public constant proxyRegistryAddress = 0xa5409ec958C83C3f309868babACA7c86DCB077c1;

//Approves this address
function isApprovedForAll(address owner, address operator)
        override
        public
        view
        returns (bool)
    {
        ProxyRegistry proxyRegistry = ProxyRegistry(proxyRegistryAddress);
        if (address(proxyRegistry.proxies(owner)) == operator) {
            return true;
        }
        return super.isApprovedForAll(owner, operator);
    }