DIR=$(dirname "$(readlink -f $0)")

docker run --rm -v $DIR/buildConf:/build -v $DIR/buildConf:/root/.m2 tb4mmaggots/maven sh run.sh  

cp $DIR/buildConf/target/*.war $DIR/runtime/webapps/
