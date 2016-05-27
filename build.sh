DIR=$(dirname "$(readlink -f $0)")

docker run --rm -v $DIR/buildConf:/build -v $DIR/buildConf:/root/.m2 tb4mmaggots/maven sh run.sh  

if [! -d "$DIR/runtime/webapps"]; then
	mkdir $DIR/runtime/webapps/
fi
cp $DIR/buildConf/target/*.war $DIR/runtime/webapps/
