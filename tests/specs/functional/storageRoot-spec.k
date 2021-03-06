requires "evm.k"
requires "edsl.k"

module VERIFICATION
    imports EVM
    imports EDSL

    syntax StepSort ::= MerkleTree | String
    syntax    KItem ::= runMerkle ( StepSort )
                      | doneMerkle( StepSort )
 // ------------------------------------------
    rule runMerkle( T ) => doneMerkle( T )

endmodule

module STORAGEROOT-SPEC
    imports VERIFICATION

    rule <k> runMerkle( #storageRoot( .Map ) )
          => doneMerkle( .MerkleTree )
         </k>

    // uint pos0;
    //
    // pos0 = 1234;
    rule <k> runMerkle( Keccak256( #rlpEncodeMerkleTree( #storageRoot(
              #hashedLocation( "Solidity", 0, .IntList ) |-> 1234
                                                                     )
                                                       )
                                 )
                      )
          => doneMerkle( "6ff6cfba457bc662332201b53a8bda503e307197962f2c51e5e2dcc3809e19be" )
         </k>

    // mapping (uint => uint) pos0;
    //
    // pos0[0] = 100;
    // pos0[1] = 200;
    rule <k> runMerkle( Keccak256( #rlpEncodeMerkleTree( #storageRoot(
              #hashedLocation( "Solidity", 0, 0 ) |-> 100
              #hashedLocation( "Solidity", 0, 1 ) |-> 200
                                                                     )
                                                       )
                                 )
                      )
          => doneMerkle( "27093708a19995cf73ddd4b27049a7e33fb49e242bde6c1bffbb6596b67b8b3e" )
         </k>

    // uint                   pos0;
    // mapping (uint => uint) pos1;
    //
    // pos0    = 600;
    // pos1[0] = 200;
    // pos1[5] = 24;
    rule <k> runMerkle( Keccak256( #rlpEncodeMerkleTree( #storageRoot(
              #hashedLocation( "Solidity", 0, .IntList ) |-> 600
              #hashedLocation( "Solidity", 1, 0 )        |-> 200
              #hashedLocation( "Solidity", 1, 5 )        |-> 24
                                                                     )
                                                       )
                                 )
                      )
          => doneMerkle( "7df5d7b198240b49434b4e1dbff02fcb0649dd91650ae0fae191b2881cbb009e" )
         </k>

    // mapping (uint => uint) pos0;
    // mapping (uint => uint) pos1;
    //
    // pos0[0] = 123;
    // pos0[1] = 456;
    // pos1[6] = 56;
    // pos1[9] = 333;
    rule <k> runMerkle( Keccak256( #rlpEncodeMerkleTree( #storageRoot(
              #hashedLocation( "Solidity", 0, 0 ) |-> 123
              #hashedLocation( "Solidity", 0, 1 ) |-> 456
              #hashedLocation( "Solidity", 1, 6 ) |-> 56
              #hashedLocation( "Solidity", 1, 9 ) |-> 333
                                                                     )
                                                       )
                                 )
                      )
          => doneMerkle( "e3d130ca69a8d33ad2058d86ba26ec414f6e5639930041d6a266ee88b25ea835" )
         </k>

    // uint                                     pos0;
    // mapping (uint => uint)                   pos1;
    // uint                                     pos2;
    // mapping (uint => mapping (uint => uint)) pos3;
    //
    // pos0       = 1234;
    // pos1[0]    = 0;
    // pos1[1]    = 1;
    // pos2       = 100;
    // pos3[0][0] = 42;
    // pos3[2][1] = 2019;
    rule <k> runMerkle( Keccak256( #rlpEncodeMerkleTree( #storageRoot(
              #hashedLocation( "Solidity", 0, .IntList ) |-> 1234
              #hashedLocation( "Solidity", 1, 0 )        |-> 0
              #hashedLocation( "Solidity", 1, 1 )        |-> 1
              #hashedLocation( "Solidity", 2, .IntList ) |-> 100
              #hashedLocation( "Solidity", 3, 0 0 )      |-> 42
              #hashedLocation( "Solidity", 3, 2 1 )      |-> 2019
                                                                     )
                                                       )
                                 )
                      )
          => doneMerkle( "6786e17b1f185ba3b51ec15f28526a1d47d74052ca98c1b8edf7cdc6243eebba" )
         </k>
endmodule
