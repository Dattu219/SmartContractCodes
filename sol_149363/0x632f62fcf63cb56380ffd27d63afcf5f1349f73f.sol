pragma solidity ^0.4.18;



// 方僥ライブラリ

/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {

    // �\麻

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }

        uint256 c = a * b;

        assert(c / a == b);

        return c;

    }



    // 茅麻

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        // assert(b > 0); // Solidity automatically throws when dividing by 0

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;

    }



    // �p麻

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        assert(b <= a);

        return a - b;

    }



    // 紗麻

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        assert(c >= a);

        return c;

    }

}





// オ�`ナ�`�慙�

/**

 * @title Ownable

 * @dev The Ownable contract has an owner address, and provides basic authorization

 *      control functions, this simplifies the implementation of "user permissions".

 */

contract Ownable {

    address public owner;



    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);



    // コンストラクタ

    /**

     * @dev The Ownable constructor sets the original `owner` of the contract to the

     *      sender account.

     */

    function Ownable() public {

        owner = msg.sender;

    }



    // modifier

    /**

     * @dev Throws if called by any account other than the owner.

     */

    modifier onlyOwner() {

        require(msg.sender == owner);

        _;

    }



    // オ�`ナ�`�慴頓�

    /**

     * @dev Allows the current owner to transfer control of the contract to a newOwner.

     * @param newOwner The address to transfer ownership to.

     */

    function transferOwnership(address newOwner) onlyOwner public {

        require(newOwner != address(0));

        OwnershipTransferred(owner, newOwner);

        owner = newOwner;

    }

}





// ERC223�ｸ�

/**

 * @title ERC223

 * @dev ERC223 contract interface with ERC20 functions and events

 *      Fully backward compatible with ERC20

 *      Recommended implementation used at https://github.com/Dexaran/ERC223-token-standard/tree/Recommended

 */

contract ERC223 {

    uint public totalSupply;



    // ERC223 and ERC20 functions and events

    function balanceOf(address who) public view returns (uint);

    function totalSupply() public view returns (uint256 _supply);

    function transfer(address to, uint value) public returns (bool ok);

    function transfer(address to, uint value, bytes data) public returns (bool ok);

    function transfer(address to, uint value, bytes data, string customFallback) public returns (bool ok);

    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);



    // ERC223 functions

    function name() public view returns (string _name);

    function symbol() public view returns (string _symbol);

    function decimals() public view returns (uint8 _decimals);



    // ERC20 functions and events

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);

    function approve(address _spender, uint256 _value) public returns (bool success);

    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(address indexed _owner, address indexed _spender, uint _value);

}





// ConractReceiver

/**

 * @title ContractReceiver

 * @dev Contract that is working with ERC223 tokens

 */

 contract ContractReceiver {



    struct TKN {

        address sender;

        uint value;

        bytes data;

        bytes4 sig;

    }



    function tokenFallback(address _from, uint _value, bytes _data) public pure {

        TKN memory tkn;

        tkn.sender = _from;

        tkn.value = _value;

        tkn.data = _data;

        uint32 u = uint32(_data[3]) + (uint32(_data[2]) << 8) + (uint32(_data[1]) << 16) + (uint32(_data[0]) << 24);

        tkn.sig = bytes4(u);



        /*

         * tkn variable is analogue of msg variable of Ether transaction

         * tkn.sender is person who initiated this token transaction   (analogue of msg.sender)

         * tkn.value the number of tokens that were sent   (analogue of msg.value)

         * tkn.data is data of token transaction   (analogue of msg.data)

         * tkn.sig is 4 bytes signature of function if data of token transaction is a function execution

         */

    }

}





// CryptoHarborExchange

/**

 * @title CryptoHarborExchange

 * @author CryptoHarborExchange Author

 * @dev CryptoHarborExchange is an ERC223 Token with ERC20 functions and events

 *      Fully backward compatible with ERC20

 */

contract CryptoHarborExchange is ERC223, Ownable {

    using SafeMath for uint256;



    string public name = "CryptoHarborExchange";

    string public symbol = "CHE";

    string public constant AAcontributors = "CryptoHarborExchange Author";

    uint8 public decimals = 8;

    uint256 public totalSupply = 50e9 * 1e8;

    uint256 public distributeAmount = 0;

    bool public mintingFinished = false;



    address public Loading = 0x8F9D96B9Ddb9b6Bdcc5BCcB6C2C2704c9Be58771;

    address public Angel = 0x0FC77220fD0b32052bB405109C9FfF678A2eeD53;

    address public Development = 0x6f40E9d6D10E0B5C29327b7134Dd54bB42dD55De;

    address public Public = 0x82a87119dd74c9459E4316ac928f544631102b8B;

    address public Management = 0xD3931315DD5AAeE4a64Ff9B4BF7a57EDB5249ba9;

    address public Lockup = 0x4828716D7845BAAA94420ccEdD0ba2cC08e3d663;



    mapping(address => uint256) public balanceOf;

    mapping(address => mapping (address => uint256)) public allowance;

    mapping (address => bool) public frozenAccount;

    mapping (address => uint256) public unlockUnixTime;



    event FrozenFunds(address indexed target, bool frozen);

    event LockedFunds(address indexed target, uint256 locked);

    //event Burn(address indexed from, uint256 amount);

    //event Mint(address indexed to, uint256 amount);

    //event MintFinished();



    // コンストラクタ

    /**

     * @dev Constructor is called only once and can not be called again

     */

    function CryptoHarborExchange() public {

        owner = 0xfB668006e725bf35b961910F4c66BEf949c17d6b;



        balanceOf[Loading] = totalSupply.mul(40).div(100);

        balanceOf[Angel] = totalSupply.mul(4).div(100);

        balanceOf[Development] = totalSupply.mul(14).div(100);

        balanceOf[Public] = totalSupply.mul(13).div(100);

        balanceOf[Management] = totalSupply.mul(10).div(100);

        balanceOf[Lockup] = totalSupply.mul(19).div(100);

    }





    function name() public view returns (string _name) {

        return name;

    }



    function symbol() public view returns (string _symbol) {

        return symbol;

    }



    function decimals() public view returns (uint8 _decimals) {

        return decimals;

    }



    function totalSupply() public view returns (uint256 _totalSupply) {

        return totalSupply;

    }



    function balanceOf(address _owner) public view returns (uint256 balance) {

        return balanceOf[_owner];

    }





    // アカウント���Y

    /**

     * @dev Prevent targets from sending or receiving tokens

     * @param targets Addresses to be frozen

     * @param isFrozen either to freeze it or not

     */

    function freezeAccounts(address[] targets, bool isFrozen) onlyOwner public {

        require(targets.length > 0);



        for (uint j = 0; j < targets.length; j++) {

            require(targets[j] != 0x0);

            frozenAccount[targets[j]] = isFrozen;

            FrozenFunds(targets[j], isFrozen);

        }

    }



    // ロックアップ

    /**

     * @dev Prevent targets from sending or receiving tokens by setting Unix times

     * @param targets Addresses to be locked funds

     * @param unixTimes Unix times when locking up will be finished

     */

    function lockupAccounts(address[] targets, uint[] unixTimes) onlyOwner public {

        require(targets.length > 0

                && targets.length == unixTimes.length);



        for(uint j = 0; j < targets.length; j++){

            require(unlockUnixTime[targets[j]] < unixTimes[j]);

            unlockUnixTime[targets[j]] = unixTimes[j];

            LockedFunds(targets[j], unixTimes[j]);

        }

    }





    // Transfer

    /**

     * @dev Function that is called when a user or another contract wants to transfer funds

     */

    function transfer(address _to, uint _value, bytes _data, string _custom_fallback) public returns (bool success) {

        require(_value > 0

                && frozenAccount[msg.sender] == false

                && frozenAccount[_to] == false

                && now > unlockUnixTime[msg.sender]

                && now > unlockUnixTime[_to]);



        if (isContract(_to)) {

            require(balanceOf[msg.sender] >= _value);

            balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);

            balanceOf[_to] = balanceOf[_to].add(_value);

            assert(_to.call.value(0)(bytes4(keccak256(_custom_fallback)), msg.sender, _value, _data));

            Transfer(msg.sender, _to, _value, _data);

            Transfer(msg.sender, _to, _value);

            return true;

        } else {

            return transferToAddress(_to, _value, _data);

        }

    }



    function transfer(address _to, uint _value, bytes _data) public  returns (bool success) {

        require(_value > 0

                && frozenAccount[msg.sender] == false

                && frozenAccount[_to] == false

                && now > unlockUnixTime[msg.sender]

                && now > unlockUnixTime[_to]);



        if (isContract(_to)) {

            return transferToContract(_to, _value, _data);

        } else {

            return transferToAddress(_to, _value, _data);

        }

    }



    /**

     * @dev Standard function transfer similar to ERC20 transfer with no _data

     *      Added due to backwards compatibility reasons

     */

    function transfer(address _to, uint _value) public returns (bool success) {

        require(_value > 0

                && frozenAccount[msg.sender] == false

                && frozenAccount[_to] == false

                && now > unlockUnixTime[msg.sender]

                && now > unlockUnixTime[_to]);



        bytes memory empty;

        if (isContract(_to)) {

            return transferToContract(_to, _value, empty);

        } else {

            return transferToAddress(_to, _value, empty);

        }

    }



    // assemble the given address bytecode. If bytecode exists then the _addr is a contract.

    function isContract(address _addr) private view returns (bool is_contract) {

        uint length;

        assembly {

            //retrieve the size of the code on target address, this needs assembly

            length := extcodesize(_addr)

        }

        return (length > 0);

    }



    // function that is called when transaction target is an address

    function transferToAddress(address _to, uint _value, bytes _data) private returns (bool success) {

        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);

        balanceOf[_to] = balanceOf[_to].add(_value);

        Transfer(msg.sender, _to, _value, _data);

        Transfer(msg.sender, _to, _value);

        return true;

    }



    // function that is called when transaction target is a contract

    function transferToContract(address _to, uint _value, bytes _data) private returns (bool success) {

        require(balanceOf[msg.sender] >= _value);

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);

        balanceOf[_to] = balanceOf[_to].add(_value);

        ContractReceiver receiver = ContractReceiver(_to);

        receiver.tokenFallback(msg.sender, _value, _data);

        Transfer(msg.sender, _to, _value, _data);

        Transfer(msg.sender, _to, _value);

        return true;

    }







    /**

     * @dev Transfer tokens from one address to another

     *      Added due to backwards compatibility with ERC20

     * @param _from address The address which you want to send tokens from

     * @param _to address The address which you want to transfer to

     * @param _value uint256 the amount of tokens to be transferred

     */

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {

        require(_to != address(0)

                && _value > 0

                && balanceOf[_from] >= _value

                && allowance[_from][msg.sender] >= _value

                && frozenAccount[_from] == false

                && frozenAccount[_to] == false

                && now > unlockUnixTime[_from]

                && now > unlockUnixTime[_to]);



        balanceOf[_from] = balanceOf[_from].sub(_value);

        balanceOf[_to] = balanceOf[_to].add(_value);

        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);

        Transfer(_from, _to, _value);

        return true;

    }



    /**

     * @dev Allows _spender to spend no more than _value tokens in your behalf

     *      Added due to backwards compatibility with ERC20

     * @param _spender The address authorized to spend

     * @param _value the max amount they can spend

     */

    function approve(address _spender, uint256 _value) public returns (bool success) {

        allowance[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

        return true;

    }



    /**

     * @dev Function to check the amount of tokens that an owner allowed to a spender

     *      Added due to backwards compatibility with ERC20

     * @param _owner address The address which owns the funds

     * @param _spender address The address which will spend the funds

     */

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {

        return allowance[_owner][_spender];

    }







    /**

     * @dev Burns a specific amount of tokens.

     * @param _from The address that will burn the tokens.

     * @param _unitAmount The amount of token to be burned.

     */

    /*

    function burn(address _from, uint256 _unitAmount) onlyOwner public {

        require(_unitAmount > 0

                && balanceOf[_from] >= _unitAmount);



        balanceOf[_from] = balanceOf[_from].sub(_unitAmount);

        totalSupply = totalSupply.sub(_unitAmount);

        Burn(_from, _unitAmount);

    }

    */

    /*

    modifier canMint() {

        require(!mintingFinished);

        _;

    }

    */

    /**

     * @dev Function to mint tokens

     * @param _to The address that will receive the minted tokens.

     * @param _unitAmount The amount of tokens to mint.

     */

    /*

    function mint(address _to, uint256 _unitAmount) onlyOwner canMint public returns (bool) {

        require(_unitAmount > 0);



        totalSupply = totalSupply.add(_unitAmount);

        balanceOf[_to] = balanceOf[_to].add(_unitAmount);

        Mint(_to, _unitAmount);

        Transfer(address(0), _to, _unitAmount);

        return true;

    }

    */

    /**

     * @dev Function to stop minting new tokens.

     */

    /*

    function finishMinting() onlyOwner canMint public returns (bool) {

        mintingFinished = true;

        MintFinished();

        return true;

    }

    */





    /**

     * @dev Function to distribute tokens to the list of addresses by the provided amount

     */

    function distributeAirdrop(address[] addresses, uint256 amount) public returns (bool) {

        require(amount > 0

                && addresses.length > 0

                && frozenAccount[msg.sender] == false

                && now > unlockUnixTime[msg.sender]);



        amount = amount.mul(1e8);

        uint256 totalAmount = amount.mul(addresses.length);

        require(balanceOf[msg.sender] >= totalAmount);



        for (uint j = 0; j < addresses.length; j++) {

            require(addresses[j] != 0x0

                    && frozenAccount[addresses[j]] == false

                    && now > unlockUnixTime[addresses[j]]);



            balanceOf[addresses[j]] = balanceOf[addresses[j]].add(amount);

            Transfer(msg.sender, addresses[j], amount);

        }

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(totalAmount);

        return true;

    }



    function distributeAirdrop(address[] addresses, uint[] amounts) public returns (bool) {

        require(addresses.length > 0

                && addresses.length == amounts.length

                && frozenAccount[msg.sender] == false

                && now > unlockUnixTime[msg.sender]);



        uint256 totalAmount = 0;



        for(uint j = 0; j < addresses.length; j++){

            require(amounts[j] > 0

                    && addresses[j] != 0x0

                    && frozenAccount[addresses[j]] == false

                    && now > unlockUnixTime[addresses[j]]);



            amounts[j] = amounts[j].mul(1e8);

            totalAmount = totalAmount.add(amounts[j]);

        }

        require(balanceOf[msg.sender] >= totalAmount);



        for (j = 0; j < addresses.length; j++) {

            balanceOf[addresses[j]] = balanceOf[addresses[j]].add(amounts[j]);

            Transfer(msg.sender, addresses[j], amounts[j]);

        }

        balanceOf[msg.sender] = balanceOf[msg.sender].sub(totalAmount);

        return true;

    }



    /**

     * @dev Function to collect tokens from the list of addresses

     */

    function collectTokens(address[] addresses, uint[] amounts) onlyOwner public returns (bool) {

        require(addresses.length > 0

                && addresses.length == amounts.length);



        uint256 totalAmount = 0;



        for (uint j = 0; j < addresses.length; j++) {

            require(amounts[j] > 0

                    && addresses[j] != 0x0

                    && frozenAccount[addresses[j]] == false

                    && now > unlockUnixTime[addresses[j]]);



            amounts[j] = amounts[j].mul(1e8);

            require(balanceOf[addresses[j]] >= amounts[j]);

            balanceOf[addresses[j]] = balanceOf[addresses[j]].sub(amounts[j]);

            totalAmount = totalAmount.add(amounts[j]);

            Transfer(addresses[j], msg.sender, amounts[j]);

        }

        balanceOf[msg.sender] = balanceOf[msg.sender].add(totalAmount);

        return true;

    }





    function setDistributeAmount(uint256 _unitAmount) onlyOwner public {

        distributeAmount = _unitAmount;

    }



    /**

     * @dev Function to distribute tokens to the msg.sender automatically

     *      If distributeAmount is 0, this function doesn't work

     */

    function autoDistribute() payable public {

        require(distributeAmount > 0

                && balanceOf[Public] >= distributeAmount

                && frozenAccount[msg.sender] == false

                && now > unlockUnixTime[msg.sender]);

        if(msg.value > 0) Public.transfer(msg.value);



        balanceOf[Public] = balanceOf[Public].sub(distributeAmount);

        balanceOf[msg.sender] = balanceOf[msg.sender].add(distributeAmount);

        Transfer(Public, msg.sender, distributeAmount);

    }



    /**

     * @dev fallback function

     */

    function() payable public {

        autoDistribute();

     }



}