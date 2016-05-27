DIR=$(dirname "$(readlink -f $0)")

docker run --rm -v $DIR/buildConf:/build -v $DIR/buildConf:/root/.m2 tb4mmaggots/maven sh run.sh  

mkdir -p $DIR/runtime/webapps

echo "Copying war file to runtime/webapps directory."
cp $DIR/buildConf/target/*.war $DIR/runtime/webapps/
echo "Build complete"

