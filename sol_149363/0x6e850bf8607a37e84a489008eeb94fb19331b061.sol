/**

 *Submitted for verification at Etherscan.io on 2018-11-04

*/



pragma solidity ^0.4.25;



/**



  EN:



  Web: http://fasteth.online/

  Telegram: https://t.me/fasteth



  Queue contract: returns 125% of each investment!



  Automatic payouts!

  No bugs, no backdoors, NO OWNER - fully automatic!

  Made and checked by professionals!



  1. Send any sum to smart contract address

     - sum from 0.05 ETH

     - min 350 000 gas limit

     - you are added to a queue

  2. Wait a little bit

  3. ...

  4. PROFIT! You have got 125%



  How is that?

  1. The first investor in the queue (you will become the

     first in some time) receives next investments until

     it become 125% of his initial investment.

  2. You will receive payments in several parts or all at once

  3. Once you receive 125% of your initial investment you are

     removed from the queue.

  4. The balance of this contract should normally be 0 because

     all the money are immediately go to payouts





     So the last pays to the first (or to several first ones

     if the deposit big enough) and the investors paid 125% are removed from the queue



                new investor --|               brand new investor --|

                 investor5     |                 new investor       |

                 investor4     |     =======>      investor5        |

                 investor3     |                   investor4        |

    (part. paid) investor2    <|                   investor3        |

    (fully paid) investor1   <-|                   investor2   <----|  (pay until 125%)



    ==> Limits: <==



    Multiplier: 125%

    Minimum deposit: 0.05ETH

    Maximum deposit: 10ETH

*/





/**



  RU:



  Web: http://fasteth.online/

  Telegram: https://t.me/fasteth



  ����ߧ��ѧܧ� ���ާߧѧ� ����֧�֧է�: �ӧ�٧ӧ�ѧ�ѧ֧� 125% ��� �ӧѧ�֧ԧ� �է֧��٧ڧ��!



  ���ӧ��ާѧ�ڧ�֧�ܧڧ� �ӧ���ݧѧ��!

  ���֧� ���ڧҧ��, �է���, �ѧӧ��ާѧ�ڧ�֧�ܧڧ� - �էݧ� �ӧ���ݧѧ� ���� ���������� �ѧէާڧߧڧ���ѧ�ڧ�!

  ����٧էѧ� �� ����ӧ֧�֧� �����֧��ڧ�ߧѧݧѧާ�!



  1. �����ݧڧ�� �ݧ�ҧ�� �ߧ֧ߧ�ݧ֧ӧ�� ���ާާ� �ߧ� �ѧէ�֧� �ܧ�ߧ��ѧܧ��

     - ���ާާ� ��� 0.05 ETH

     - gas limit �ާڧߧڧާ�� 350 000

     - �ӧ� �ӧ��ѧߧ֧�� �� ���֧�֧է�

  2. ���֧ާߧ�ԧ� ���է�اէڧ��

  3. ...

  4. PROFIT! ���ѧ� ���ڧ�ݧ� 125% ��� �ӧѧ�֧ԧ� �է֧��٧ڧ��.



  ���ѧ� ���� �ӧ�٧ާ�اߧ�?

  1. ���֧�ӧ��� �ڧߧӧ֧���� �� ���֧�֧է� (�ӧ� ���ѧߧ֧�� ��֧�ӧ��� ���֧ߧ� ��ܧ���) ���ݧ��ѧ֧� �ӧ���ݧѧ�� ���

     �ߧ�ӧ��� �ڧߧӧ֧������ �է� ��֧� ����, ���ܧ� �ߧ� ���ݧ��ڧ� 125% ��� ��ӧ�֧ԧ� �է֧��٧ڧ��

  2. ������ݧѧ�� �ާ�ԧ�� ���ڧ��էڧ�� �ߧ֧�ܧ�ݧ�ܧڧާ� ��ѧ���ާ� �ڧݧ� �ӧ�� ���ѧ٧�

  3. ���ѧ� ���ݧ�ܧ� �ӧ� ���ݧ��ѧ֧�� 125% ��� �ӧѧ�֧ԧ� �է֧��٧ڧ��, �ӧ� ��էѧݧ�֧�֧�� �ڧ� ���֧�֧է�

  4. ���ѧݧѧߧ� ����ԧ� �ܧ�ߧ��ѧܧ�� �է�ݧا֧� ��ҧ���ߧ� �ҧ���� �� ��ѧۧ�ߧ� 0, �����ާ� ���� �ӧ�� �������ݧ֧ߧڧ�

     ���ѧ٧� �ا� �ߧѧ��ѧӧݧ����� �ߧ� �ӧ���ݧѧ��



     ���ѧܧڧ� ��ҧ�ѧ٧��, ����ݧ֧էߧڧ� ��ݧѧ��� ��֧�ӧ���, �� �ڧߧӧ֧�����, �է���ڧԧ�ڧ� �ӧ���ݧѧ� 125% ��� �է֧��٧ڧ��,

     ��էѧݧ����� �ڧ� ���֧�֧է�, ������ѧ� �ާ֧��� ����ѧݧ�ߧ���



              �ߧ�ӧ��� �ڧߧӧ֧���� --|            ���ӧ�֧� �ߧ�ӧ��� �ڧߧӧ֧���� --|

                 �ڧߧӧ֧����5     |                �ߧ�ӧ��� �ڧߧӧ֧����      |

                 �ڧߧӧ֧����4     |     =======>      �ڧߧӧ֧����5        |

                 �ڧߧӧ֧����3     |                   �ڧߧӧ֧����4        |

 (��ѧ��. �ӧ���ݧѧ��) �ڧߧӧ֧����2    <|                   �ڧߧӧ֧����3        |

(���ݧߧѧ� �ӧ���ݧѧ��) �ڧߧӧ֧����1   <-|                   �ڧߧӧ֧����2   <----|  (�է��ݧѧ�� �է� 125%)



    ==> ���ڧާڧ��: <==



    ������ڧ�: 125%

    ���ڧߧڧާѧݧ�ߧ��� �ӧܧݧѧ�: 0.05 ETH

    ���ѧܧ�ڧާѧݧ�ߧ��� �ӧܧݧѧ�: 10 ETH





*/

contract FastEth {



	//Address for promo expences

    address constant private PROMO1 = 0xaC780d067c52227ac7563FBe975eD9A8F235eb35;

	address constant private PROMO2 = 0x6dBFFf54E23Cf6DB1F72211e0683a5C6144E8F03;

	address constant private CASHBACK = 0x33cA4CbC4b171c32C16c92AFf9feE487937475F8;

	address constant private PRIZE	= 0xeE9B823ef62FfB79aFf2C861eDe7d632bbB5B653;

	

	//Percent for promo expences

    uint constant public PERCENT = 4;

    

    //Bonus prize

    uint constant public BONUS_PERCENT = 5;

	

    // Start time

    uint constant StartEpoc = 1541354370;                     

                         

    //The deposit structure holds all the info about the deposit made

    struct Deposit {

        address depositor; // The depositor address

        uint deposit;   // The deposit amount

        uint payout; // Amount already paid

    }



    Deposit[] public queue;  // The queue

    mapping (address => uint) public depositNumber; // investor deposit index

    uint public currentReceiverIndex; // The index of the depositor in the queue

    uint public totalInvested; // Total invested amount



    //This function receives all the deposits

    //stores them and make immediate payouts

    function () public payable {

        

        require(now >= StartEpoc);



        if(msg.value > 0){



            require(gasleft() >= 250000); // We need gas to process queue

            require(msg.value >= 0.05 ether && msg.value <= 10 ether); // Too small and too big deposits are not accepted

            

            // Add the investor into the queue

            queue.push( Deposit(msg.sender, msg.value, 0) );

            depositNumber[msg.sender] = queue.length;



            totalInvested += msg.value;



            //Send some promo to enable queue contracts to leave long-long time

            uint promo1 = msg.value*PERCENT/100;

            PROMO1.transfer(promo1);

			uint promo2 = msg.value*PERCENT/100;

            PROMO2.transfer(promo2);

			uint cashback = msg.value*PERCENT/100;

			CASHBACK.transfer(cashback);

            uint prize = msg.value*BONUS_PERCENT/100;

            PRIZE.transfer(prize);

            

            // Pay to first investors in line

            pay();



        }

    }



    // Used to pay to current investors

    // Each new transaction processes 1 - 4+ investors in the head of queue

    // depending on balance and gas left

    function pay() internal {



        uint money = address(this).balance;

        uint multiplier = 125;



        // We will do cycle on the queue

        for (uint i = 0; i < queue.length; i++){



            uint idx = currentReceiverIndex + i;  //get the index of the currently first investor



            Deposit storage dep = queue[idx]; // get the info of the first investor



            uint totalPayout = dep.deposit * multiplier / 100;

            uint leftPayout;



            if (totalPayout > dep.payout) {

                leftPayout = totalPayout - dep.payout;

            }



            if (money >= leftPayout) { //If we have enough money on the contract to fully pay to investor



                if (leftPayout > 0) {

                    dep.depositor.transfer(leftPayout); // Send money to him

                    money -= leftPayout;

                }



                // this investor is fully paid, so remove him

                depositNumber[dep.depositor] = 0;

                delete queue[idx];



            } else{



                // Here we don't have enough money so partially pay to investor

                dep.depositor.transfer(money); // Send to him everything we have

                dep.payout += money;       // Update the payout amount

                break;                     // Exit cycle



            }



            if (gasleft() <= 55000) {         // Check the gas left. If it is low, exit the cycle

                break;                       // The next investor will process the line further

            }

        }



        currentReceiverIndex += i; //Update the index of the current first investor

    }

    

    //Returns your position in queue

    function getDepositsCount(address depositor) public view returns (uint) {

        uint c = 0;

        for(uint i=currentReceiverIndex; i<queue.length; ++i){

            if(queue[i].depositor == depositor)

                c++;

        }

        return c;

    }



    // Get current queue size

    function getQueueLength() public view returns (uint) {

        return queue.length - currentReceiverIndex;

    }



}