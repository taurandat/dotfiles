export PI_DIR="$HOME/src/competitive-programming"

alias pi="cd $PI_DIR && cd"

alias open_stack="ulimit -s unlimited"
alias clean_test="rm -f *.in *.ok"
alias now="gdate +%s.%N"

new() {
    cp "$PI_DIR/template.cpp" "$1"
}

cp_run() {
    if (( $# < 1 )); then
        echo "Usage: cp_run source"
    fi

    g++ -O1 -std=gnu++14 -Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic "$1" -o "$2"
    ./${2}.out
}

check() {
    if (( $# > 5 )) ; then
        echo "Usage: check src_1 src_2 test_generator #_test_from #_test_to"
        return
    fi

    echo "Compiling default solution."
    cppcheck "$1"
    cp_run "$1" a
    echo "Default solution compiled."

    if (( $# >= 2 )); then
        echo "Compiling alternative solution."
        cppcheck "$2"
        cp_run "$2" b
        echo "Alternative solution compiled."
    fi

    if (( $# >= 3 )); then
        echo "Compiling test generator."
        cppcheck "$3"
        cp_run "$3" c
        echo "Test generator compiled."

        printf "Generating tests: "
        for i in `seq -w $4 $5`; do
            printf "$i "
            ./c >> $i.in
        done
        num_tests=$5-$4+1
        echo "\n$num_tests tests generated."
    fi

    echo "Checking test cases."
    tested=0; passed=0
    for i in *.in; do
        local start=$(now)
        ./a < $i >> ${i%in}re
        local end=$(now)
        run_time=$(echo "$end - $start" | bc)

        if (( $# >= 2 )); then
            ./b < $i >> ${i%in}ok
        fi

        diff -u ${i%in}re ${i%in}ok
        if [ $? -ne 0 ]; then
            echo "${i%.in}: FAILED"
            echo "Expected:"; cat ${i%in}ok
            echo "Got:"; cat ${i%in}re
        else
            echo "${i%.in}: PASSED. Ran in $run_time seconds."
            let passed++
        fi
        let tested++
    done

    echo "Passed $passed/$tested tests."

    rm -f *.re
    rm -f a b c
}
