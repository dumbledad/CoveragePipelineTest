# CoveragePipelineTest
Exploration of unexpected results from the coverage section of our build pipeline.

## Execution
1. Make sure the script is executable
    ```
    chmod 777 coverage.sh
    ```

2. Run the script
    ```
    ./coverage.sh
    ```

3. Check the exit code
    ```
    echo $?
    ```

## Results
The coverage section of our build pipeline appears to check that functions are tested, but not the results of the tests. I.e.
we attain 100% coverage when there is at least one unit test that exercises each function, regardless of whether or not the
tests pass.

## Correction
The final commit adds code to the script to save the output of the unit test run and to check
for failed tests. The key change is to swap this
```
find ./ -name 'test_*.py' | xargs -n 1 coverage run -a --include=$INCLUDE
```
to this
```
(find ./ -name 'test_*.py' | xargs -n 1 coverage run -a --include=$INCLUDE) 2>&1 | tee tmp.testing.txt
FAILS=$(awk '/FAIL/ {print $2; exit}' tmp.testing.txt)
if [ "$FAILS" != 0 ]
then echo Some unit tests fail.
        exit 1
fi
```
##### Tim Regan, 8th June 2020
