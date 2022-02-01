DIR="openwrt-imagebuilder"

## update the image builder
# copy over required files
cp -r additions/* ${DIR}/

## run the image builder
cd ${DIR}/
bash build.sh
retval=$?

echo " "
if [ $retval -eq 0 ]; then
    echo "> Compiled firmware at ${DIR}/bin/targets/ramips/mt76x8/"
else
    echo "> Compilation error!"
fi