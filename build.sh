# Z3_DIR=~/z3-4.6.0-x64-ubuntu-16.04
# export PATH=$Z3_DIR/bin:$PATH
# export LD_LIBRARY_PATH=$Z3_DIR/bin:$LD_LIBRARY_PATH

# git submodule update --init --recursive -- deps/k
# ( cd deps/k              && mvn package -DskipTests -Dllvm.backend.skip -Dhaskell.backend.skip )

# git submodule update        --recursive -- deps/k
# ( cd deps/k && mvn clean && mvn package -DskipTests -Dllvm.backend.skip -Dhaskell.backend.skip )

  make clean
  make java-defn
# rm -rf .build/defn/java/driver-kompiled
# make build-java
  kompile -v --debug --backend java -I .build/defn/java -d .build/defn/java --main-module ETHEREUM-SIMULATION --syntax-module ETHEREUM-SIMULATION .build/defn/java/driver.k
