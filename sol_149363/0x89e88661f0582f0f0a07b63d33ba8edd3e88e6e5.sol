/**

 *Submitted for verification at Etherscan.io on 2018-10-31

*/



pragma solidity ^0.4.25;



/**

  Multiplier contract: returns 111%-141% of each investment!

  Automatic payouts!

  No bugs, no backdoors, NO OWNER - fully automatic!

  Made and checked by professionals!



  1. Send any sum to smart contract address

     - sum from 0.01 to 10 ETH

     - min 250000 gas limit

     - you are added to a queue

  2. Wait a little bit

  3. ...

  4. PROFIT! You have got 111-141%



  How is that?

  1. The first investor in the queue (you will become the

     first in some time) receives next investments until

     it become 111-141% of his initial investment.

  2. You will receive payments in several parts or all at once

  3. Once you receive 111-141% of your initial investment you are

     removed from the queue.

  4. You can make multiple deposits

  5. The balance of this contract should normally be 0 because

     all the money are immediately go to payouts

  6. The more deposits you make the more multiplier you get. See MULTIPLIERS var

  7. If you are the last depositor (no deposits after you in 20 mins)

     you get 2% of all the ether that were on the contract. Send 0 to withdraw it.

     Do it BEFORE NEXT RESTART!

  8. The contract automatically restarts each 24 hours at 17:00 GMT





     So the last pays to the first (or to several first ones

     if the deposit big enough) and the investors paid 111-141% are removed from the queue



                new investor --|               brand new investor --|

                 investor5     |                 new investor       |

                 investor4     |     =======>      investor5        |

                 investor3     |                   investor4        |

    (part. paid) investor2    <|                   investor3        |

    (fully paid) investor1   <-|                   investor2   <----|  (pay until full %)





  ����ߧ��ѧܧ� ���ާߧ�اڧ�֧ݧ�: �ӧ�٧ӧ�ѧ�ѧ֧� 111%-141% ��� �ӧѧ�֧ԧ� �է֧��٧ڧ��!

  ���ӧ��ާѧ�ڧ�֧�ܧڧ� �ӧ���ݧѧ��!

  ���֧� ���ڧҧ��, �է���, �ѧӧ��ާѧ�ڧ�֧�ܧڧ� - �էݧ� �ӧ���ݧѧ� ���� ���������� �ѧէާڧߧڧ���ѧ�ڧ�!

  ����٧էѧ� �� ����ӧ֧�֧� �����֧��ڧ�ߧѧݧѧާ�!



  1. �����ݧڧ�� �ݧ�ҧ�� �ߧ֧ߧ�ݧ֧ӧ�� ���ާާ� �ߧ� �ѧէ�֧� �ܧ�ߧ��ѧܧ��

     - ���ާާ� ��� 0.01 �է� 10 ETH

     - gas limit �ާڧߧڧާ�� 250000

     - �ӧ� �ӧ��ѧߧ֧�� �� ���֧�֧է�

  2. ���֧ާߧ�ԧ� ���է�اէڧ��

  3. ...

  4. PROFIT! ���ѧ� ���ڧ�ݧ� 111%-141% ��� �ӧѧ�֧ԧ� �է֧��٧ڧ��.



  ���ѧ� ���� �ӧ�٧ާ�اߧ�?

  1. ���֧�ӧ��� �ڧߧӧ֧���� �� ���֧�֧է� (�ӧ� ���ѧߧ֧�� ��֧�ӧ��� ���֧ߧ� ��ܧ���) ���ݧ��ѧ֧� �ӧ���ݧѧ�� ���

     �ߧ�ӧ��� �ڧߧӧ֧������ �է� ��֧� ����, ���ܧ� �ߧ� ���ݧ��ڧ� 111%-141% ��� ��ӧ�֧ԧ� �է֧��٧ڧ��

  2. ������ݧѧ�� �ާ�ԧ�� ���ڧ��էڧ�� �ߧ֧�ܧ�ݧ�ܧڧާ� ��ѧ���ާ� �ڧݧ� �ӧ�� ���ѧ٧�

  3. ���ѧ� ���ݧ�ܧ� �ӧ� ���ݧ��ѧ֧�� 111%-141% ��� �ӧѧ�֧ԧ� �է֧��٧ڧ��, �ӧ� ��էѧݧ�֧�֧�� �ڧ� ���֧�֧է�

  4. ���� �ާ�ا֧�� �է֧ݧѧ�� �ߧ֧�ܧ�ݧ�ܧ� �է֧��٧ڧ��� ���ѧ٧�

  5. ���ѧݧѧߧ� ����ԧ� �ܧ�ߧ��ѧܧ�� �է�ݧا֧� ��ҧ���ߧ� �ҧ���� �� ��ѧۧ�ߧ� 0, �����ާ� ���� �ӧ�� �������ݧ֧ߧڧ�

     ���ѧ٧� �ا� �ߧѧ��ѧӧݧ����� �ߧ� �ӧ���ݧѧ��

  6. ���֧� �ҧ�ݧ��� �ӧ� ��է֧ݧѧݧ� �է֧��٧ڧ���, ��֧� �ҧ�ݧ��ڧ� �����֧ߧ� �ӧ� ���ݧ��ѧ֧�� �ߧ� ���֧�֧էߧ�� �է֧��٧ڧ�

     ���ާ���ڧ�� ��֧�֧ާ֧ߧߧ�� MULTIPLIERS �� �ܧ�ߧ��ѧܧ��

  7. ����ݧ� �ӧ� ����ݧ֧էߧڧ� �ӧܧݧѧէ�ڧ� (����ݧ� �ӧѧ� �ߧ� ��է֧ݧѧ� �է֧��٧ڧ� �� ��֧�֧ߧڧ� 20 �ާڧߧ��), ��� �ӧ� �ާ�ا֧��

     �٧ѧҧ�ѧ�� ���ڧ٧�ӧ�� ���ߧ� - 2% ��� ���ڧ��, �����֧է�֧ԧ� ��֧�֧� �ܧ�ߧ��ѧܧ�. �����ݧڧ�� 0 �ߧ� �ܧ�ߧ��ѧܧ�

     �� �ԧѧ٧�� �ߧ� �ާ֧ߧ֧� 350000, ����ҧ� �֧ԧ� ���ݧ��ڧ��.

  8. ����ߧ��ѧܧ� �ѧӧ��ާѧ�ڧ�֧�ܧ� ���ѧ���֧� �ܧѧاէ��� ����ܧ� �� 20:00 MSK





     ���ѧܧڧ� ��ҧ�ѧ٧��, ����ݧ֧էߧڧ� ��ݧѧ��� ��֧�ӧ���, �� �ڧߧӧ֧�����, �է���ڧԧ�ڧ� �ӧ���ݧѧ� 111%-141% ��� �է֧��٧ڧ��,

     ��էѧݧ����� �ڧ� ���֧�֧է�, ������ѧ� �ާ֧��� ����ѧݧ�ߧ���



              �ߧ�ӧ��� �ڧߧӧ֧���� --|            ���ӧ�֧� �ߧ�ӧ��� �ڧߧӧ֧���� --|

                 �ڧߧӧ֧����5     |                �ߧ�ӧ��� �ڧߧӧ֧����      |

                 �ڧߧӧ֧����4     |     =======>      �ڧߧӧ֧����5        |

                 �ڧߧӧ֧����3     |                   �ڧߧӧ֧����4        |

 (��ѧ��. �ӧ���ݧѧ��) �ڧߧӧ֧����2    <|                   �ڧߧӧ֧����3        |

(���ݧߧѧ� �ӧ���ݧѧ��) �ڧߧӧ֧����1   <-|                   �ڧߧӧ֧����2   <----|  (�է��ݧѧ�� �է� 111%-141%)



*/



contract Multipliers {

    //Address of old Multiplier

    address constant private FATHER = 0x7CDfA222f37f5C4CCe49b3bBFC415E8C911D1cD8;

    //Address for tech expences

    address constant private TECH = 0xDb058D036768Cfa9a94963f99161e3c94aD6f5dA;

    //Address for promo expences

    address constant private PROMO = 0xdA149b17C154e964456553C749B7B4998c152c9E;

    //Percent for first multiplier donation

    uint constant public FATHER_PERCENT = 1;

    uint constant public TECH_PERCENT = 2;

    uint constant public PROMO_PERCENT = 2;

    uint constant public PRIZE_PERCENT = 2;

    uint constant public MAX_INVESTMENT = 10 ether;

    uint constant public MIN_INVESTMENT_FOR_PRIZE = 0.05 ether;

    uint constant public MAX_IDLE_TIME = 20 minutes; //Maximum time the deposit should remain the last to receive prize



    //How many percent for your deposit to be multiplied

    //Depends on number of deposits from specified address at this stage

    //The more deposits the higher the multiplier

    uint8[] MULTIPLIERS = [

        111, //For first deposit made at this stage

        113, //For second

        117, //For third

        121, //For forth

        125, //For fifth

        130, //For sixth

        135, //For seventh

        141  //For eighth and on

    ];



    //The deposit structure holds all the info about the deposit made

    struct Deposit {

        address depositor; //The depositor address

        uint128 deposit;   //The deposit amount

        uint128 expect;    //How much we should pay out (initially it is 111%-141% of deposit)

    }



    struct DepositCount {

        int128 stage;

        uint128 count;

    }



    struct LastDepositInfo {

        uint128 index;

        uint128 time;

    }



    Deposit[] private queue;  //The queue

    uint public currentReceiverIndex = 0; //The index of the first depositor in the queue. The receiver of investments!

    LastDepositInfo public lastDepositInfo; //The time last deposit made at



    uint public prizeAmount = 0; //Prize amount accumulated for the last depositor

    int public stage = 0; //Number of contract runs

    mapping(address => DepositCount) public depositsMade; //The number of deposits of different depositors



    //This function receives all the deposits

    //stores them and make immediate payouts

    function () public payable {

        //If money are from first multiplier, just add them to the balance

        //All these money will be distributed to current investors

        if(msg.value > 0 && msg.sender != FATHER){

            require(gasleft() >= 220000, "We require more gas!"); //We need gas to process queue

            require(msg.value <= MAX_INVESTMENT, "The investment is too much!"); //Do not allow too big investments to stabilize payouts



            checkAndUpdateStage();



            addDeposit(msg.sender, msg.value);



            //Pay to first investors in line

            pay();

        }else if(msg.value == 0){

            withdrawPrize();

        }

    }



    //Used to pay to current investors

    //Each new transaction processes 1 - 4+ investors in the head of queue

    //depending on balance and gas left

    function pay() private {

        //Try to send all the money on contract to the first investors in line

        uint balance = address(this).balance;

        uint128 money = 0;

        if(balance > prizeAmount) //The opposite is impossible, however the check will not do any harm

            money = uint128(balance - prizeAmount);



        //We will do cycle on the queue

        for(uint i=currentReceiverIndex; i<queue.length; i++){



            Deposit storage dep = queue[i]; //get the info of the first investor



            if(money >= dep.expect){  //If we have enough money on the contract to fully pay to investor

                dep.depositor.send(dep.expect); //Send money to him

                money -= dep.expect;            //update money left



                //this investor is fully paid, so remove him

                delete queue[i];

            }else{

                //Here we don't have enough money so partially pay to investor

                dep.depositor.send(money); //Send to him everything we have

                dep.expect -= money;       //Update the expected amount

                break;                     //Exit cycle

            }



            if(gasleft() <= 50000)         //Check the gas left. If it is low, exit the cycle

                break;                     //The next investor will process the line further

        }



        currentReceiverIndex = i; //Update the index of the current first investor

    }



    function addDeposit(address depositor, uint value) private {

        //Count the number of the deposit at this stage

        DepositCount storage c = depositsMade[depositor];

        if(c.stage != stage){

            c.stage = int128(stage);

            c.count = 0;

        }



        //If you are applying for the prize you should invest more than minimal amount

        //Otherwize it doesn't count

        if(value >= MIN_INVESTMENT_FOR_PRIZE)

            lastDepositInfo = LastDepositInfo(uint128(queue.length), uint128(now));



        //Compute the multiplier percent for this depositor

        uint multiplier = getDepositorMultiplier(depositor);

        //Add the investor into the queue. Mark that he expects to receive 111%-141% of deposit back

        queue.push(Deposit(depositor, uint128(value), uint128(value*multiplier/100)));



        //Increment number of deposits the depositors made this round

        c.count++;



        //Save money for prize and father multiplier

        prizeAmount += value*(FATHER_PERCENT + PRIZE_PERCENT)/100;



        //Send small part to tech support

        uint support = value*TECH_PERCENT/100;

        TECH.send(support);

        uint adv = value*PROMO_PERCENT/100;

        PROMO.send(adv);



    }



    function checkAndUpdateStage() private{

        int _stage = getCurrentStageByTime();



        require(_stage >= stage, "We should only go forward in time");



        if(_stage != stage){

            proceedToNewStage(_stage);

        }

    }



    function proceedToNewStage(int _stage) private {

        //Clean queue info

        //The prize amount on the balance is left the same if not withdrawn

        stage = _stage;

        delete queue;

        currentReceiverIndex = 0;

        delete lastDepositInfo;

    }



    function withdrawPrize() private {

        //You can withdraw prize only if the last deposit was more than MAX_IDLE_TIME ago

        require(lastDepositInfo.time > 0 && lastDepositInfo.time <= now - MAX_IDLE_TIME, "The last depositor is not confirmed yet");

        //Last depositor will receive prize only if it has not been fully paid

        require(currentReceiverIndex <= lastDepositInfo.index, "The last depositor should still be in queue");



        uint balance = address(this).balance;

        if(prizeAmount > balance) //Impossible but better check it

            prizeAmount = balance;



        //Send donation to the first multiplier for it to spin faster

        //It already contains all the sum, so we must split for father and last depositor only

        uint donation = prizeAmount*FATHER_PERCENT/(FATHER_PERCENT + PRIZE_PERCENT);

        require(FATHER.call.value(donation).gas(gasleft())());



        uint prize = prizeAmount - donation;

        queue[lastDepositInfo.index].depositor.send(prize);



        prizeAmount = 0;

        proceedToNewStage(stage + 1);

    }



    //Get the deposit info by its index

    //You can get deposit index from

    function getDeposit(uint idx) public view returns (address depositor, uint deposit, uint expect){

        Deposit storage dep = queue[idx];

        return (dep.depositor, dep.deposit, dep.expect);

    }



    //Get the count of deposits of specific investor

    function getDepositsCount(address depositor) public view returns (uint) {

        uint c = 0;

        for(uint i=currentReceiverIndex; i<queue.length; ++i){

            if(queue[i].depositor == depositor)

                c++;

        }

        return c;

    }



    //Get all deposits (index, deposit, expect) of a specific investor

    function getDeposits(address depositor) public view returns (uint[] idxs, uint128[] deposits, uint128[] expects) {

        uint c = getDepositsCount(depositor);



        idxs = new uint[](c);

        deposits = new uint128[](c);

        expects = new uint128[](c);



        if(c > 0) {

            uint j = 0;

            for(uint i=currentReceiverIndex; i<queue.length; ++i){

                Deposit storage dep = queue[i];

                if(dep.depositor == depositor){

                    idxs[j] = i;

                    deposits[j] = dep.deposit;

                    expects[j] = dep.expect;

                    j++;

                }

            }

        }

    }



    //Get current queue size

    function getQueueLength() public view returns (uint) {

        return queue.length - currentReceiverIndex;

    }



    //Get current depositors multiplier percent at this stage

    function getDepositorMultiplier(address depositor) public view returns (uint) {

        DepositCount storage c = depositsMade[depositor];

        uint count = 0;

        if(c.stage == getCurrentStageByTime())

            count = c.count;

        if(count < MULTIPLIERS.length)

            return MULTIPLIERS[count];



        return MULTIPLIERS[MULTIPLIERS.length - 1];

    }



    function getCurrentStageByTime() public view returns (int) {

        return int(now - 17 hours) / 1 days - 17835; //Start is 31/10/2018 20:00 GMT+3

    }



    function getStageStartTime(int _stage) public pure returns (int) {

        return 17 hours + (_stage + 17835)*1 days;

    }



    function getCurrentCandidateForPrize() public view returns (address addr, int timeLeft){

        Deposit storage d = queue[lastDepositInfo.index];

        addr = d.depositor;

        timeLeft = int(lastDepositInfo.time + MAX_IDLE_TIME) - int(now);

    }



}