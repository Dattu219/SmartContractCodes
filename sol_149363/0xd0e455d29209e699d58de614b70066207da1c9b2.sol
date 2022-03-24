/**

 *Submitted for verification at Etherscan.io on 2018-09-27

*/



pragma solidity ^0.4.24;



/*

******************** https://doubledivs.cash/exchange/ *********************

*                                  

*      _______   ______    __    __  .______    __       _______                       

*     |       \ /  __  \  |  |  |  | |   _  \  |  |     |   ____|                      

*     |  .--.  |  |  |  | |  |  |  | |  |_)  | |  |     |  |__                         

*     |  |  |  |  |  |  | |  |  |  | |   _  <  |  |     |   __|                        

*     |  '--'  |  `--'  | |  `--'  | |  |_)  | |  `----.|  |____                       

*     |_______/ \______/   \______/  |______/  |_______||_______|                                                 

*      _______   __  ____    ____   _______.                                           

*     |       \ |  | \   \  /   /  /       |                                           

*     |  .--.  ||  |  \   \/   /  |   (----`                                           

*     |  |  |  ||  |   \      /    \   \                                               

*     |  '--'  ||  |    \    / .----)   |                                              

*     |_______/ |__|     \__/  |_______/                                                                                                                                

*      __________   ___   ______  __    __       ___      .__   __.   _______  _______ 

*     |   ____\  \ /  /  /      ||  |  |  |     /   \     |  \ |  |  /  _____||   ____|

*     |  |__   \  V  /  |  ,----'|  |__|  |    /  ^  \    |   \|  | |  |  __  |  |__   

*     |   __|   >   <   |  |     |   __   |   /  /_\  \   |  . `  | |  | |_ | |   __|  

*     |  |____ /  .  \  |  `----.|  |  |  |  /  _____  \  |  |\   | |  |__| | |  |____ 

*     |_______/__/ \__\  \______||__|  |__| /__/     \__\ |__| \__|  \______| |_______|

*                                                                                       

*     DOUBLEDIVS 50% DIVIDENDS. FOREVER.

*     

*     https://doubledivs.cash/

*     https://doubledivs.cash/exchange/

*

******************** https://doubledivs.cash/exchange/ *********************

*

*

* [x] 25% Exchange fee (Split to Token Divs + Double Divs + Referral)

* [x] 18% Dividends to all DDIVS holders

* [x] 5% Dividends to Double Divs

* [x] 0% Account transfer fees

* [x] 2% To Dev Fund for future development costs

* [x] Double Divs Dividend Account: 0x85EcbC22e9c0Ad0c1Cb3F4465582493bADc50433

* [x] Multi-tier Masternode system for exchange buys and sells (3 levels)

* [x] Refferal approximate % breakdown (4% for 1st, 2.4% for 2nd, 1.6% 3rd)

* [x] Double Divs (DDIVS) Token can be used for future games

*

* Official Website: https://doubledivs.cash/

* Official Exchange: https://doubledivs.cash/exchange

* Official Discord: https://discord.gg/YRTWtJ6

* Official Twitter: https://twitter.com/DoubleDivs

* Official Telegram: https://t.me/DoubleDivs

*/





/**

 * Definition of contract accepting Double Divs (DDIVS) tokens

 * Games or any other innovative platforms can reuse this contract to support Double Divs (DDIVS) tokens

 */

contract AcceptsDDIVS {

    DDIVS public tokenContract;



    constructor(address _tokenContract) public {

        tokenContract = DDIVS(_tokenContract);

    }



    modifier onlyTokenContract {

        require(msg.sender == address(tokenContract));

        _;

    }



    /**

    * @dev Standard ERC677 function that will handle incoming token transfers.

    *

    * @param _from  Token sender address.

    * @param _value Amount of tokens.

    * @param _data  Transaction metadata.

    */

    function tokenFallback(address _from, uint256 _value, bytes _data) external returns (bool);

}





contract DDIVS {

    /*=================================

    =            MODIFIERS            =

    =================================*/

    // only people with tokens

    modifier onlyBagholders() {

        require(myTokens() > 0);

        _;

    }



    // only people with profits

    modifier onlyStronghands() {

        require(myDividends(true) > 0);

        _;

    }



    modifier notContract() {

      require (msg.sender == tx.origin);

      _;

    }



    // administrators can:

    // -> change the name of the contract

    // -> change the name of the token

    // -> change the PoS difficulty (How many tokens it costs to hold a masternode)

    // they CANNOT:

    // -> take funds

    // -> disable withdrawals

    // -> kill the contract

    // -> change the price of tokens

    modifier onlyAdministrator(){

        address _customerAddress = msg.sender;

        require(administrators[_customerAddress]);

        _;

    }

    

    uint ACTIVATION_TIME = 1538028000;





    // ensures that the first tokens in the contract will be equally distributed

    // meaning, no divine dump will be ever possible

    // result: healthy longevity.

    modifier antiEarlyWhale(uint256 _amountOfEthereum){

        address _customerAddress = msg.sender;

        

        if (now >= ACTIVATION_TIME) {

            onlyAmbassadors = false;

        }



        // are we still in the vulnerable phase?

        // if so, enact anti early whale protocol

        if( onlyAmbassadors && ((totalEthereumBalance() - _amountOfEthereum) <= ambassadorQuota_ )){

            require(

                // is the customer in the ambassador list?

                ambassadors_[_customerAddress] == true &&



                // does the customer purchase exceed the max ambassador quota?

                (ambassadorAccumulatedQuota_[_customerAddress] + _amountOfEthereum) <= ambassadorMaxPurchase_



            );



            // updated the accumulated quota

            ambassadorAccumulatedQuota_[_customerAddress] = SafeMath.add(ambassadorAccumulatedQuota_[_customerAddress], _amountOfEthereum);



            // execute

            _;

        } else {

            // in case the ether count drops low, the ambassador phase won't reinitiate

            onlyAmbassadors = false;

            _;

        }



    }



    /*==============================

    =            EVENTS            =

    ==============================*/

    event onTokenPurchase(

        address indexed customerAddress,

        uint256 incomingEthereum,

        uint256 tokensMinted,

        address indexed referredBy

    );



    event onTokenSell(

        address indexed customerAddress,

        uint256 tokensBurned,

        uint256 ethereumEarned

    );



    event onReinvestment(

        address indexed customerAddress,

        uint256 ethereumReinvested,

        uint256 tokensMinted

    );



    event onWithdraw(

        address indexed customerAddress,

        uint256 ethereumWithdrawn

    );



    // ERC20

    event Transfer(

        address indexed from,

        address indexed to,

        uint256 tokens

    );





    /*=====================================

    =            CONFIGURABLES            =

    =====================================*/

    string public name = "DDIVS";

    string public symbol = "DDIVS";

    uint8 constant public decimals = 18;

    uint8 constant internal dividendFee_ = 18; // 18% dividend fee for double divs tokens on each buy and sell

    uint8 constant internal fundFee_ = 7; // 7% investment fund fee to buy double divs on each buy and sell

    uint256 constant internal tokenPriceInitial_ = 0.00000001 ether;

    uint256 constant internal tokenPriceIncremental_ = 0.00000001 ether;

    uint256 constant internal magnitude = 2**64;



    // Address to send the 1% Fee

    address public giveEthFundAddress = 0x85EcbC22e9c0Ad0c1Cb3F4465582493bADc50433;

    bool public finalizedEthFundAddress = false;

    uint256 public totalEthFundRecieved; // total ETH charity recieved from this contract

    uint256 public totalEthFundCollected; // total ETH charity collected in this contract



    // proof of stake (defaults at 100 tokens)

    uint256 public stakingRequirement = 25e18;



    // ambassador program

    mapping(address => bool) internal ambassadors_;

    uint256 constant internal ambassadorMaxPurchase_ = 0.75 ether;

    uint256 constant internal ambassadorQuota_ = 1.5 ether;







   /*================================

    =            DATASETS            =

    ================================*/

    // amount of shares for each address (scaled number)

    mapping(address => uint256) internal tokenBalanceLedger_;

    mapping(address => uint256) internal referralBalance_;

    mapping(address => int256) internal payoutsTo_;

    mapping(address => uint256) internal ambassadorAccumulatedQuota_;

    uint256 internal tokenSupply_ = 0;

    uint256 internal profitPerShare_;



    // administrator list (see above on what they can do)

    mapping(address => bool) public administrators;



    // when this is set to true, only ambassadors can purchase tokens (this prevents a whale premine, it ensures a fairly distributed upper pyramid)

    bool public onlyAmbassadors = true;



    // Special Double Divs Platform control from scam game contracts on Double Divs platform

    mapping(address => bool) public canAcceptTokens_; // contracts, which can accept Double Divs tokens



    mapping(address => address) public stickyRef;



    /*=======================================

    =            PUBLIC FUNCTIONS            =

    =======================================*/

    /*

    * -- APPLICATION ENTRY POINTS --

    */

    constructor()

        public

    {

        // add administrators here

        administrators[0x28F0088308CDc140C2D72fBeA0b8e529cAA5Cb40] = true;



        // add the ambassadors here - Tokens will be distributed to these addresses from main premine

        ambassadors_[0x41FE3738B503cBaFD01C1Fd8DD66b7fE6Ec11b01] = true;

        // add the ambassadors here - Tokens will be distributed to these addresses from main premine

        ambassadors_[0x28F0088308CDc140C2D72fBeA0b8e529cAA5Cb40] = true;

    }





    /**

     * Converts all incoming ethereum to tokens for the caller, and passes down the referral addy (if any)

     */

    function buy(address _referredBy)

        public

        payable

        returns(uint256)

    {

        

        require(tx.gasprice <= 0.05 szabo);

        purchaseTokens(msg.value, _referredBy);

    }



    /**

     * Fallback function to handle ethereum that was send straight to the contract

     * Unfortunately we cannot use a referral address this way.

     */

    function()

        payable

        public

    {

        

        require(tx.gasprice <= 0.05 szabo);

        purchaseTokens(msg.value, 0x0);

    }



    function updateFundAddress(address _newAddress)

        onlyAdministrator()

        public

    {

        require(finalizedEthFundAddress == false);

        giveEthFundAddress = _newAddress;

    }



    function finalizeFundAddress(address _finalAddress)

        onlyAdministrator()

        public

    {

        require(finalizedEthFundAddress == false);

        giveEthFundAddress = _finalAddress;

        finalizedEthFundAddress = true;

    }



    /**

     * Sends FUND money to the Dev Fee Contract

     * The address is here https://etherscan.io/address/0x85EcbC22e9c0Ad0c1Cb3F4465582493bADc50433

     */

    function payFund() payable public {

        uint256 ethToPay = SafeMath.sub(totalEthFundCollected, totalEthFundRecieved);

        require(ethToPay > 0);

        totalEthFundRecieved = SafeMath.add(totalEthFundRecieved, ethToPay);

        if(!giveEthFundAddress.call.value(ethToPay)()) {

            revert();

        }

    }



    /**

     * Converts all of caller's dividends to tokens.

     */

    function reinvest()

        onlyStronghands()

        public

    {

        // fetch dividends

        uint256 _dividends = myDividends(false); // retrieve ref. bonus later in the code



        // pay out the dividends virtually

        address _customerAddress = msg.sender;

        payoutsTo_[_customerAddress] +=  (int256) (_dividends * magnitude);



        // retrieve ref. bonus

        _dividends += referralBalance_[_customerAddress];

        referralBalance_[_customerAddress] = 0;



        // dispatch a buy order with the virtualized "withdrawn dividends"

        uint256 _tokens = purchaseTokens(_dividends, 0x0);



        // fire event

        emit onReinvestment(_customerAddress, _dividends, _tokens);

    }



    /**

     * Alias of sell() and withdraw().

     */

    function exit()

        public

    {

        // get token count for caller & sell them all

        address _customerAddress = msg.sender;

        uint256 _tokens = tokenBalanceLedger_[_customerAddress];

        if(_tokens > 0) sell(_tokens);



        // lambo delivery service

        withdraw();

    }



    /**

     * Withdraws all of the callers earnings.

     */

    function withdraw()

        onlyStronghands()

        public

    {

        // setup data

        address _customerAddress = msg.sender;

        uint256 _dividends = myDividends(false); // get ref. bonus later in the code



        // update dividend tracker

        payoutsTo_[_customerAddress] +=  (int256) (_dividends * magnitude);



        // add ref. bonus

        _dividends += referralBalance_[_customerAddress];

        referralBalance_[_customerAddress] = 0;



        // lambo delivery service

        _customerAddress.transfer(_dividends);



        // fire event

        emit onWithdraw(_customerAddress, _dividends);

    }



    /**

     * Liquifies tokens to ethereum.

     */

    function sell(uint256 _amountOfTokens)

        onlyBagholders()

        public

    {

        // setup data

        address _customerAddress = msg.sender;

        // russian hackers BTFO

        require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);

        uint256 _tokens = _amountOfTokens;

        uint256 _ethereum = tokensToEthereum_(_tokens);



        uint256 _dividends = SafeMath.div(SafeMath.mul(_ethereum, dividendFee_), 100);

        uint256 _fundPayout = SafeMath.div(SafeMath.mul(_ethereum, fundFee_), 100);

        uint256 _refPayout = _dividends / 3;

        _dividends = SafeMath.sub(_dividends, _refPayout);

        (_dividends,) = handleRef(stickyRef[msg.sender], _refPayout, _dividends, 0);



        // Take out dividends and then _fundPayout

        uint256 _taxedEthereum =  SafeMath.sub(SafeMath.sub(_ethereum, _dividends), _fundPayout);



        // Add ethereum to send to fund

        totalEthFundCollected = SafeMath.add(totalEthFundCollected, _fundPayout);



        // burn the sold tokens

        tokenSupply_ = SafeMath.sub(tokenSupply_, _tokens);

        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _tokens);



        // update dividends tracker

        int256 _updatedPayouts = (int256) (profitPerShare_ * _tokens + (_taxedEthereum * magnitude));

        payoutsTo_[_customerAddress] -= _updatedPayouts;



        // dividing by zero is a bad idea

        if (tokenSupply_ > 0) {

            // update the amount of dividends per token

            profitPerShare_ = SafeMath.add(profitPerShare_, (_dividends * magnitude) / tokenSupply_);

        }



        // fire event

        emit onTokenSell(_customerAddress, _tokens, _taxedEthereum);

    }





    /**

     * Transfer tokens from the caller to a new holder.

     * REMEMBER THIS IS 0% TRANSFER FEE

     */

    function transfer(address _toAddress, uint256 _amountOfTokens)

        onlyBagholders()

        public

        returns(bool)

    {

        // setup

        address _customerAddress = msg.sender;



        // make sure we have the requested tokens

        // also disables transfers until ambassador phase is over

        // ( we dont want whale premines )

        require(_amountOfTokens <= tokenBalanceLedger_[_customerAddress]);



        // withdraw all outstanding dividends first

        if(myDividends(true) > 0) withdraw();



        // exchange tokens

        tokenBalanceLedger_[_customerAddress] = SafeMath.sub(tokenBalanceLedger_[_customerAddress], _amountOfTokens);

        tokenBalanceLedger_[_toAddress] = SafeMath.add(tokenBalanceLedger_[_toAddress], _amountOfTokens);



        // update dividend trackers

        payoutsTo_[_customerAddress] -= (int256) (profitPerShare_ * _amountOfTokens);

        payoutsTo_[_toAddress] += (int256) (profitPerShare_ * _amountOfTokens);





        // fire event

        emit Transfer(_customerAddress, _toAddress, _amountOfTokens);



        // ERC20

        return true;

    }



    /**

    * Transfer token to a specified address and forward the data to recipient

    * ERC-677 standard

    * https://github.com/ethereum/EIPs/issues/677

    * @param _to    Receiver address.

    * @param _value Amount of tokens that will be transferred.

    * @param _data  Transaction metadata.

    */

    function transferAndCall(address _to, uint256 _value, bytes _data) external returns (bool) {

      require(_to != address(0));

      require(canAcceptTokens_[_to] == true); // security check that contract approved by Double Divs platform

      require(transfer(_to, _value)); // do a normal token transfer to the contract



      if (isContract(_to)) {

        AcceptsDDIVS receiver = AcceptsDDIVS(_to);

        require(receiver.tokenFallback(msg.sender, _value, _data));

      }



      return true;

    }



    /**

     * Additional check that the game address we are sending tokens to is a contract

     * assemble the given address bytecode. If bytecode exists then the _addr is a contract.

     */

     function isContract(address _addr) private constant returns (bool is_contract) {

       // retrieve the size of the code on target address, this needs assembly

       uint length;

       assembly { length := extcodesize(_addr) }

       return length > 0;

     }



    /*----------  ADMINISTRATOR ONLY FUNCTIONS  ----------*/

    /**

     * In case the amassador quota is not met, the administrator can manually disable the ambassador phase.

     */

    //function disableInitialStage()

    //    onlyAdministrator()

    //    public

    //{

    //    onlyAmbassadors = false;

    //}



    /**

     * In case one of us dies, we need to replace ourselves.

     */

    function setAdministrator(address _identifier, bool _status)

        onlyAdministrator()

        public

    {

        administrators[_identifier] = _status;

    }



    /**

     * Precautionary measures in case we need to adjust the masternode rate.

     */

    function setStakingRequirement(uint256 _amountOfTokens)

        onlyAdministrator()

        public

    {

        stakingRequirement = _amountOfTokens;

    }



    /**

     * Add or remove game contract, which can accept Double Divs (DDIVS) tokens

     */

    function setCanAcceptTokens(address _address, bool _value)

      onlyAdministrator()

      public

    {

      canAcceptTokens_[_address] = _value;

    }



    /**

     * If we want to rebrand, we can.

     */

    function setName(string _name)

        onlyAdministrator()

        public

    {

        name = _name;

    }



    /**

     * If we want to rebrand, we can.

     */

    function setSymbol(string _symbol)

        onlyAdministrator()

        public

    {

        symbol = _symbol;

    }





    /*----------  HELPERS AND CALCULATORS  ----------*/

    /**

     * Method to view the current Ethereum stored in the contract

     * Example: totalEthereumBalance()

     */

    function totalEthereumBalance()

        public

        view

        returns(uint)

    {

        return address(this).balance;

    }



    /**

     * Retrieve the total token supply.

     */

    function totalSupply()

        public

        view

        returns(uint256)

    {

        return tokenSupply_;

    }



    /**

     * Retrieve the tokens owned by the caller.

     */

    function myTokens()

        public

        view

        returns(uint256)

    {

        address _customerAddress = msg.sender;

        return balanceOf(_customerAddress);

    }



    /**

     * Retrieve the dividends owned by the caller.

     * If `_includeReferralBonus` is to to 1/true, the referral bonus will be included in the calculations.

     * The reason for this, is that in the frontend, we will want to get the total divs (global + ref)

     * But in the internal calculations, we want them separate.

     */

    function myDividends(bool _includeReferralBonus)

        public

        view

        returns(uint256)

    {

        address _customerAddress = msg.sender;

        return _includeReferralBonus ? dividendsOf(_customerAddress) + referralBalance_[_customerAddress] : dividendsOf(_customerAddress) ;

    }



    /**

     * Retrieve the token balance of any single address.

     */

    function balanceOf(address _customerAddress)

        view

        public

        returns(uint256)

    {

        return tokenBalanceLedger_[_customerAddress];

    }



    /**

     * Retrieve the dividend balance of any single address.

     */

    function dividendsOf(address _customerAddress)

        view

        public

        returns(uint256)

    {

        return (uint256) ((int256)(profitPerShare_ * tokenBalanceLedger_[_customerAddress]) - payoutsTo_[_customerAddress]) / magnitude;

    }



    /**

     * Return the buy price of 1 individual token.

     */

    function sellPrice()

        public

        view

        returns(uint256)

    {

        // our calculation relies on the token supply, so we need supply. Doh.

        if(tokenSupply_ == 0){

            return tokenPriceInitial_ - tokenPriceIncremental_;

        } else {

            uint256 _ethereum = tokensToEthereum_(1e18);

            uint256 _dividends = SafeMath.div(SafeMath.mul(_ethereum, dividendFee_), 100);

            uint256 _fundPayout = SafeMath.div(SafeMath.mul(_ethereum, fundFee_), 100);

            uint256 _taxedEthereum = SafeMath.sub(SafeMath.sub(_ethereum, _dividends), _fundPayout);

            return _taxedEthereum;

        }

    }



    /**

     * Return the sell price of 1 individual token.

     */

    function buyPrice()

        public

        view

        returns(uint256)

    {

        // our calculation relies on the token supply, so we need supply. Doh.

        if(tokenSupply_ == 0){

            return tokenPriceInitial_ + tokenPriceIncremental_;

        } else {

            uint256 _ethereum = tokensToEthereum_(1e18);

            uint256 _dividends = SafeMath.div(SafeMath.mul(_ethereum, dividendFee_), 100);

            uint256 _fundPayout = SafeMath.div(SafeMath.mul(_ethereum, fundFee_), 100);

            uint256 _taxedEthereum =  SafeMath.add(SafeMath.add(_ethereum, _dividends), _fundPayout);

            return _taxedEthereum;

        }

    }



    /**

     * Function for the frontend to dynamically retrieve the price scaling of buy orders.

     */

    function calculateTokensReceived(uint256 _ethereumToSpend)

        public

        view

        returns(uint256)

    {

        uint256 _dividends = SafeMath.div(SafeMath.mul(_ethereumToSpend, dividendFee_), 100);

        uint256 _fundPayout = SafeMath.div(SafeMath.mul(_ethereumToSpend, fundFee_), 100);

        uint256 _taxedEthereum = SafeMath.sub(SafeMath.sub(_ethereumToSpend, _dividends), _fundPayout);

        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);

        return _amountOfTokens;

    }



    /**

     * Function for the frontend to dynamically retrieve the price scaling of sell orders.

     */

    function calculateEthereumReceived(uint256 _tokensToSell)

        public

        view

        returns(uint256)

    {

        require(_tokensToSell <= tokenSupply_);

        uint256 _ethereum = tokensToEthereum_(_tokensToSell);

        uint256 _dividends = SafeMath.div(SafeMath.mul(_ethereum, dividendFee_), 100);

        uint256 _fundPayout = SafeMath.div(SafeMath.mul(_ethereum, fundFee_), 100);

        uint256 _taxedEthereum = SafeMath.sub(SafeMath.sub(_ethereum, _dividends), _fundPayout);

        return _taxedEthereum;

    }



    /**

     * Function for the frontend to show ether waiting to be send to fund in contract

     */

    function etherToSendFund()

        public

        view

        returns(uint256) {

        return SafeMath.sub(totalEthFundCollected, totalEthFundRecieved);

    }





    /*==========================================

    =            INTERNAL FUNCTIONS            =

    ==========================================*/



    // Make sure we will send back excess if user sends more then 5 ether before 100 ETH in contract

    function purchaseInternal(uint256 _incomingEthereum, address _referredBy)

      notContract()// no contracts allowed

      internal

      returns(uint256) {



      uint256 purchaseEthereum = _incomingEthereum;

      uint256 excess;

      if(purchaseEthereum > 2.5 ether) { // check if the transaction is over 2.5 ether

          if (SafeMath.sub(address(this).balance, purchaseEthereum) <= 100 ether) { // if so check the contract is less then 100 ether

              purchaseEthereum = 2.5 ether;

              excess = SafeMath.sub(_incomingEthereum, purchaseEthereum);

          }

      }



      purchaseTokens(purchaseEthereum, _referredBy);



      if (excess > 0) {

        msg.sender.transfer(excess);

      }

    }



    function handleRef(address _ref, uint _referralBonus, uint _currentDividends, uint _currentFee) internal returns (uint, uint){

        uint _dividends = _currentDividends;

        uint _fee = _currentFee;

        address _referredBy = stickyRef[msg.sender];

        if (_referredBy == address(0x0)){

            _referredBy = _ref;

        }

        // is the user referred by a masternode?

        if(

            // is this a referred purchase?

            _referredBy != 0x0000000000000000000000000000000000000000 &&



            // no cheating!

            _referredBy != msg.sender &&



            // does the referrer have at least X whole tokens?

            // i.e is the referrer a godly chad masternode

            tokenBalanceLedger_[_referredBy] >= stakingRequirement

        ){

            // wealth redistribution

            if (stickyRef[msg.sender] == address(0x0)){

                stickyRef[msg.sender] = _referredBy;

            }

            referralBalance_[_referredBy] = SafeMath.add(referralBalance_[_referredBy], _referralBonus/2);

            address currentRef = stickyRef[_referredBy];

            if (currentRef != address(0x0) && tokenBalanceLedger_[currentRef] >= stakingRequirement){

                referralBalance_[currentRef] = SafeMath.add(referralBalance_[currentRef], (_referralBonus/10)*3);

                currentRef = stickyRef[currentRef];

                if (currentRef != address(0x0) && tokenBalanceLedger_[currentRef] >= stakingRequirement){

                    referralBalance_[currentRef] = SafeMath.add(referralBalance_[currentRef], (_referralBonus/10)*2);

                }

                else{

                    _dividends = SafeMath.add(_dividends, _referralBonus - _referralBonus/2 - (_referralBonus/10)*3);

                    _fee = _dividends * magnitude;

                }

            }

            else{

                _dividends = SafeMath.add(_dividends, _referralBonus - _referralBonus/2);

                _fee = _dividends * magnitude;

            }

            

            

        } else {

            // no ref purchase

            // add the referral bonus back to the global dividends cake

            _dividends = SafeMath.add(_dividends, _referralBonus);

            _fee = _dividends * magnitude;

        }

        return (_dividends, _fee);

    }





    function purchaseTokens(uint256 _incomingEthereum, address _referredBy)

        antiEarlyWhale(_incomingEthereum)

        internal

        returns(uint256)

    {

        // data setup

        uint256 _undividedDividends = SafeMath.div(SafeMath.mul(_incomingEthereum, dividendFee_), 100);

        uint256 _referralBonus = SafeMath.div(_undividedDividends, 3);

        uint256 _fundPayout = SafeMath.div(SafeMath.mul(_incomingEthereum, fundFee_), 100);

        uint256 _dividends = SafeMath.sub(_undividedDividends, _referralBonus);

        uint256 _fee;

        (_dividends, _fee) = handleRef(_referredBy, _referralBonus, _dividends, _fee);

        uint256 _taxedEthereum = SafeMath.sub(SafeMath.sub(_incomingEthereum, _dividends), _fundPayout);

        totalEthFundCollected = SafeMath.add(totalEthFundCollected, _fundPayout);



        uint256 _amountOfTokens = ethereumToTokens_(_taxedEthereum);





        // no point in continuing execution if OP is a poor russian hacker

        // prevents overflow in the case that the pyramid somehow magically starts being used by everyone in the world

        // (or hackers)

        // and yes we know that the safemath function automatically rules out the "greater then" equasion.

        require(_amountOfTokens > 0 && (SafeMath.add(_amountOfTokens,tokenSupply_) > tokenSupply_));







        // we can't give people infinite ethereum

        if(tokenSupply_ > 0){

 

            // add tokens to the pool

            tokenSupply_ = SafeMath.add(tokenSupply_, _amountOfTokens);



            // take the amount of dividends gained through this transaction, and allocates them evenly to each shareholder

            profitPerShare_ += (_dividends * magnitude / (tokenSupply_));



            // calculate the amount of tokens the customer receives over his purchase

            _fee = _fee - (_fee-(_amountOfTokens * (_dividends * magnitude / (tokenSupply_))));



        } else {

            // add tokens to the pool

            tokenSupply_ = _amountOfTokens;

        }



        // update circulating supply & the ledger address for the customer

        tokenBalanceLedger_[msg.sender] = SafeMath.add(tokenBalanceLedger_[msg.sender], _amountOfTokens);



        // Tells the contract that the buyer doesn't deserve dividends for the tokens before they owned them;

        //really i know you think you do but you don't

        int256 _updatedPayouts = (int256) ((profitPerShare_ * _amountOfTokens) - _fee);

        payoutsTo_[msg.sender] += _updatedPayouts;



        // fire event

        emit onTokenPurchase(msg.sender, _incomingEthereum, _amountOfTokens, _referredBy);



        return _amountOfTokens;

    }



    /**

     * Calculate Token price based on an amount of incoming ethereum

     * It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;

     * Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.

     */

    function ethereumToTokens_(uint256 _ethereum)

        internal

        view

        returns(uint256)

    {

        uint256 _tokenPriceInitial = tokenPriceInitial_ * 1e18;

        uint256 _tokensReceived =

         (

            (

                // underflow attempts BTFO

                SafeMath.sub(

                    (sqrt

                        (

                            (_tokenPriceInitial**2)

                            +

                            (2*(tokenPriceIncremental_ * 1e18)*(_ethereum * 1e18))

                            +

                            (((tokenPriceIncremental_)**2)*(tokenSupply_**2))

                            +

                            (2*(tokenPriceIncremental_)*_tokenPriceInitial*tokenSupply_)

                        )

                    ), _tokenPriceInitial

                )

            )/(tokenPriceIncremental_)

        )-(tokenSupply_)

        ;



        return _tokensReceived;

    }



    /**

     * Calculate token sell value.

     * It's an algorithm, hopefully we gave you the whitepaper with it in scientific notation;

     * Some conversions occurred to prevent decimal errors or underflows / overflows in solidity code.

     */

     function tokensToEthereum_(uint256 _tokens)

        internal

        view

        returns(uint256)

    {



        uint256 tokens_ = (_tokens + 1e18);

        uint256 _tokenSupply = (tokenSupply_ + 1e18);

        uint256 _etherReceived =

        (

            // underflow attempts BTFO

            SafeMath.sub(

                (

                    (

                        (

                            tokenPriceInitial_ +(tokenPriceIncremental_ * (_tokenSupply/1e18))

                        )-tokenPriceIncremental_

                    )*(tokens_ - 1e18)

                ),(tokenPriceIncremental_*((tokens_**2-tokens_)/1e18))/2

            )

        /1e18);

        return _etherReceived;

    }





    //This is where all your gas goes, sorry

    //Not sorry, you probably only paid 1 gwei

    function sqrt(uint x) internal pure returns (uint y) {

        uint z = (x + 1) / 2;

        y = x;

        while (z < y) {

            y = z;

            z = (x / z + z) / 2;

        }

    }

}



/**

 * @title SafeMath

 * @dev Math operations with safety checks that throw on error

 */

library SafeMath {



    /**

    * @dev Multiplies two numbers, throws on overflow.

    */

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }

        uint256 c = a * b;

        assert(c / a == b);

        return c;

    }



    /**

    * @dev Integer division of two numbers, truncating the quotient.

    */

    function div(uint256 a, uint256 b) internal pure returns (uint256) {

        // assert(b > 0); // Solidity automatically throws when dividing by 0

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;

    }



    /**

    * @dev Substracts two numbers, throws on overflow (i.e. if subtrahend is greater than minuend).

    */

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {

        assert(b <= a);

        return a - b;

    }



    /**

    * @dev Adds two numbers, throws on overflow.

    */

    function add(uint256 a, uint256 b) internal pure returns (uint256) {

        uint256 c = a + b;

        assert(c >= a);

        return c;

    }

}