#
# coverage run --include=a_module.py test_a_module.py
# coverage report --show-missing
#
# chmod 777 coverage.sh
# ./coverage.sh
# echo $?
#
export PYTHONPATH=`pwd`
INCLUDE=$(find ./ -name '*.py' |  grep --extended-regexp --invert-match '/test_|^test_' | tr '\n' , | sed 's/,$//')
coverage erase
(find ./ -name 'test_*.py' | xargs -n 1 coverage run -a --include=$INCLUDE) 2>&1 | tee tmp.testing.txt
FAILS=$(awk '/FAIL/ {print $2; exit}' tmp.testing.txt)
if [ "$FAILS" != 0 ]
then echo Some unit tests fail.
        exit 1
fi
coverage report -m --skip-covered > tmp.coverage.txt
MISSING=$(awk '/TOTAL/ {print $3; exit}' tmp.coverage.txt)
if [ "$MISSING" != 0 ]
then cat tmp.coverage.txt
        echo Unit tests all pass, but $MISSING lines of code were not covered.
        exit 1
fi