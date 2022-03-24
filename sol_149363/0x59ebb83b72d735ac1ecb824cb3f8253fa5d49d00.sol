pragma solidity ^0.4.8;

contract Token{

    // token������Ĭ�ϻ�Ϊpublic��������һ��getter�����ӿڣ�����ΪtotalSupply().

    uint256 public totalSupply;  //����

    uint256 public teamlock;  //�Ŷ�����

    uint256 public foundationlock;//���������

    uint256 public mininglock;//�ڿ�����

    uint256 public releaseTime;//����ʱ��

    uint256 public starttime;//���������

    /// ��ȡ�˻�_ownerӵ��token������ 

    function balanceOf(address _owner) constant returns (uint256 balance);



    //����Ϣ�������˻�����_to�˻�ת����Ϊ_value��token

    function transfer(address _to, uint256 _value) returns (bool success);



    //���˻�_from�����˻�_toת����Ϊ_value��token����approve�������ʹ��

    function transferFrom(address _from, address _to, uint256 _value) returns   

    (bool success);



    //��Ϣ�����˻������˻�_spender�ܴӷ����˻���ת������Ϊ_value��token

    function approve(address _spender, uint256 _value) returns (bool success);



    //��ȡ�˻�_spender���Դ��˻�_owner��ת��token������

    function allowance(address _owner, address _spender) constant returns 

    (uint256 remaining);



    //����ת��ʱ����Ҫ�������¼� 

    event Transfer(address indexed _from, address indexed _to, uint256 _value);



    //������approve(address _spender, uint256 _value)�ɹ�ִ��ʱ���봥�����¼�

    event Approval(address indexed _owner, address indexed _spender, uint256 

    _value);

}



contract StandardToken is Token {

    function transfer(address _to, uint256 _value) returns (bool success) {

        //Ĭ��totalSupply ���ᳬ�����ֵ (2^256 - 1).

        //�������ʱ������ƽ������µ�token���ɣ������������������������쳣

        //require(balances[msg.sender] >= _value && balances[_to] + _value > balances[_to]);

        require(balances[msg.sender] >= _value);

        balances[msg.sender] -= _value;//����Ϣ�������˻��м�ȥtoken����_value

        balances[_to] += _value;//�������˻�����token����_value

        Transfer(msg.sender, _to, _value);//����ת�ҽ����¼�

        return true;

    }





    function transferFrom(address _from, address _to, uint256 _value) returns 

    (bool success) {

        //require(balances[_from] >= _value && allowed[_from][msg.sender] >= 

        // _value && balances[_to] + _value > balances[_to]);

        require(balances[_from] >= _value && allowed[_from][msg.sender] >= _value);

        balances[_to] += _value;//�����˻�����token����_value

        balances[_from] -= _value; //֧���˻�_from��ȥtoken����_value

        allowed[_from][msg.sender] -= _value;//��Ϣ�����߿��Դ��˻�_from��ת������������_value

        Transfer(_from, _to, _value);//����ת�ҽ����¼�

        return true;

    }

    function balanceOf(address _owner) constant returns (uint256 balance) {

        return balances[_owner];

    }





    function approve(address _spender, uint256 _value) returns (bool success)   

    {

        allowed[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

        return true;

    }





    function allowance(address _owner, address _spender) constant returns (uint256 remaining) {

        return allowed[_owner][_spender];//����_spender��_owner��ת����token��

    }

    mapping (address => uint256) balances;

    mapping (address => mapping (address => uint256)) allowed;

}



contract HumanStandardToken is StandardToken { 



    /* Public variables of the token */

    string public name;                 //����: 

    uint8 public decimals;              //����С��λ��

    string public symbol;               //token���

   

    string public version = 'H0.1';    //�汾



    function HumanStandardToken() {

        //balances[msg.sender] = _initialAmount; // ��ʼtoken����������Ϣ������

       

        totalSupply          =1000000000;  //����

        balances[msg.sender] =300000000;   //������ͨ

        teamlock             =150000000;   //�Ŷ�����

        foundationlock       =100000000;   //���������

        mininglock           =450000000;   //�ڿ�����

        name = 'DPSChain token';           //token����

        decimals = 0;                      //С��λ��

        symbol = 'DPST';                   // token���

        releaseTime=365*3*24*60*60;        //����ʱ��

        starttime=block.timestamp;

       

    }

    

      

    function unlocktoken(address _team, address _foundation, address _mining) returns 

    (bool success) {

        //require(block.timestamp >= releaseTime);

        require(block.timestamp >= starttime+releaseTime);

        require(teamlock > 0);

        require(foundationlock > 0);

        require(mininglock > 0);

        

         balances[_team] +=teamlock;  //�Ŷ�����

         teamlock-=150000000;

         Transfer(this, _team, teamlock);//����ת�ҽ����¼�

         

        balances[_foundation] +=foundationlock;//���������

        foundationlock-=100000000;

        Transfer(this, _foundation, foundationlock);//����ת�ҽ����¼�

        

        

        balances[_mining] +=mininglock;//�ڿ�����

         mininglock-=450000000;

        Transfer(this, _mining, mininglock);//����ת�ҽ����¼�

        

        return true;

    }

    

   



    /* Approves and then calls the receiving contract */

    

    function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {

        allowed[msg.sender][_spender] = _value;

        Approval(msg.sender, _spender, _value);

        //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.

        //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)

        //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.

        require(_spender.call(bytes4(bytes32(sha3("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));

        return true;

    }



}