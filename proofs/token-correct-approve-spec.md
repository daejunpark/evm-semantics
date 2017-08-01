Hacker Gold Token (HKG) Correct Program Specification
=====================================================

Here we provide a specification file containing a reachability rule for the verifying the correctness of the HKG Token's APPROVE Function.

```{.k}
module APPROVE-SPEC
imports ETHEREUM-SIMULATION
 
 rule
        <k> #execute ... </k>
        <exit-code> 1       </exit-code>
        <mode>      NORMAL  </mode>
        <schedule>  DEFAULT </schedule>
        <ethereum>
            <evm>
                <output>        .WordStack         </output>
                <memoryUsed>    3                  </memoryUsed>
                <callDepth>     0                  </callDepth>
                <callStack>     .List              </callStack>
                <interimStates> .List              </interimStates>
                <callLog>       .Set               </callLog>
                <txExecState>
		    <program>      %HKG_Program                                  </program>
                    <id>           %ACCT_ID                                      </id>
                    <caller>       %CALLER_ID                                    </caller>
                    <callData>     .WordStack                                    </callData>
                    <callValue>    0                                             </callValue>
                    <wordStack>    2000 :  %ORIGIN_ID : WS   => ?A:WordStack     </wordStack>
                    <localMem>     .Map    => ?B:Map                             </localMem>
                    <pc>           574     => 810                                </pc>
                    <gas>          G       => G -Int 7031                        </gas>
                    <previousGas>  _       => _                                    </previousGas>
                 </txExecState>
                <substate>
                    <selfDestruct> .Set             </selfDestruct>
                    <log>          .Set => _           </log>
                    <refund>       0  => _          </refund>
                </substate>
                <gasPrice>     _                                                </gasPrice>
                <origin>       %ORIGIN_ID					</origin>
                <gasLimit>     _                                                </gasLimit>
                <coinbase>     %COINBASE_VALUE                                   </coinbase>
                <timestamp>    1                                                </timestamp>
                <number>       0                                                </number>
                <previousHash> 0                                                </previousHash>
                <difficulty>   256                                              </difficulty>
            </evm>
            <network>
                <activeAccounts>   SetItem ( %ACCT_ID )   </activeAccounts>
                <accounts>
                    <account>
                        <acctID>   %ACCT_ID  </acctID>
                        <balance>  BAL                                  </balance>
                        <code>     %HKG_Program                          </code>
                        <storage> 
				   ...
				  %ACCT_1_BALANCE |-> B1:Int
				  %ACCT_1_ALLOWED |-> A1:Int
				  %ACCT_2_BALANCE |-> B2:Int
				  %ACCT_2_ALLOWED |-> A2:Int
				  3 |-> %ORIGIN_ID
			          4 |->%CALLER_ID
                                     ... 		                 </storage>
                        <acctMap> "nonce" |-> 0 </acctMap>
                    </account>
                </accounts>
                <messages> .Bag </messages>
            </network>
        </ethereum>
       requires #sizeWordStack(WS) <Int 1014  andBool G >=Int 7031
		

endmodule

```