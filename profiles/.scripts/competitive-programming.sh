export PI_DIR="$HOME/src/competitive-programming/cp"

alias pi="cd $PI_DIR && cd"

alias open_stack="ulimit -s unlimited"
alias clean_test="rm -f *.in *.ok"
alias now="gdate +%s.%N"

cp_new() {
    cp "$PI_DIR/template.cpp" "$1"
}

cp_compile() {
    if (( $# < 1 )); then
        echo "Usage: cp_compile source binary_output"
    fi

    g++ -O1 -std=gnu++14 -Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic "$1" -o "${2}.out"
}

cp_check() {
    if (( $# > 5 )) ; then
        echo "${bold}Usage${normal}: check src_1 src_2 test_generator #_test_from #_test_to"
        return
    fi

    echo "${bold}Compiling default solution${normal} ${1}"
    cppcheck "$1"
    cp_compile "$1" a
    echo "${bold}Default solution${normal} ${1} ${bold}successfully compiled!${normal}"
    long_separator

    if (( $# >= 2 )); then
        echo "${bold}Compiling alternative solution${normal} ${2}..."
        cppcheck "$2"
        cp_compile "$2" b
        echo "${bold}Alternative solution${normal} ${2} ${bold}successfully compiled!${normal}"
        long_separator
    fi

    if (( $# >= 3 )); then
        echo "${bold}Compiling test generator${normal} ${3}..."
        cppcheck "$3"
        cp_run "$3" c
        echo "${bold}Test generator${normal} ${3} ${bold}successfully compiled!${normal}"

        printf "Generating tests: "
        for i in `seq -w $4 $5`; do
            printf "$i "
            ./c.out >> $i.in
        done
        num_tests=$5-$4+1
        echo "\n${num_tests} tests generated."
        long_separator
    fi

    echo "${bold}Checking test cases...${normal}"
    tested=0; passed=0
    for i in *.in; do
        local start=$(now)
        ./a.out < $i >> ${i%in}re
        local end=$(now)
        run_time=$(echo "${end} - ${start}" | bc)

        if (( $# >= 2 )); then
            ./b.out < $i >> ${i%in}ok
        fi

        diff -u ${i%in}re ${i%in}ok > /dev/null
        if [ $? -ne 0 ]; then
            echo "${i%.in}: ${bold}${red}FAILED!${nocolor}${normal}"
            echo "Expected:"; cat ${i%in}ok
            echo "Got:"; cat ${i%in}re
        else
            printf "%s: ${bold}PASSED${normal}. Ran in %.2f seconds.\n" ${i%.in} ${run_time}
            let passed++
        fi
        let tested++
    done

    echo "Passed ${passed}/${tested} tests."
    long_separator

    rm -f *.re
    rm -f a.out b.out c.out
}
