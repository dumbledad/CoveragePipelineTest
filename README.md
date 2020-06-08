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

##### Tim Regan, 8th June 2020
