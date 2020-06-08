#
# coverage run --include=a_module.py test_a_module.py
# coverage report --show-missing
#
# chmod 777 coverage.sh
# ./coverage.sh
# echo $?
#
export PYTHONPATH=`pwd`
INCLUDE=$(find ./ -name '*.py' | grep -v ^test_ | tr '\n' , | sed 's/,$//')
coverage erase
find ./ -name 'test_*.py' | xargs -n 1 coverage run -a --include=$INCLUDE
coverage report -m --skip-covered > tmp.coverage.txt
MISSING=$(awk '/TOTAL/ {print $3; exit}' tmp.coverage.txt)
if [ "$MISSING" != 0 ]
then cat tmp.coverage.txt
        echo Tests all pass, but $MISSING lines of code were not covered.
        exit 1
fi