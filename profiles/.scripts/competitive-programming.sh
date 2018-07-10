export PI_DIR="$HOME/src/competitive-programming/"

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
        return
    fi

    g++ -O1 -std=gnu++14 -Wall -Wextra -Wshadow -Wnon-virtual-dtor -pedantic "$1" -o "${2}.out"
}

cp_check() {
    if (( $# > 5 )) ; then
        echo "${bold}Usage${normal}: check src_1 src_2 test_generator #_test_from #_test_to"
        return
    fi

    echo "${bold}Default solution${normal}: ${yellow}${1}${normal}"
    printf "> cppcheck: "
    cppcheck "$1" > /dev/null
    if [ $? -ne 0 ]; then
        printf "${red}failed${normal}\n"
        return
    fi
    printf "${green}passed${normal}\n"
    printf "> g++: "
    cp_compile "$1" a
    if [ $? -ne 0 ]; then
        printf "${red}failed${normal}\n"
        return
    fi
    printf "${green}compiled${normal}\n"
    long_separator

    if (( $# >= 2 )); then
        echo "${bold}Alternative solution${normal}: ${yellow}${2}${normal}..."
        printf "> cppcheck: "
        cppcheck "$2" > /dev/null
        if [ $? -ne 0 ]; then
            printf "${red}failed${normal}\n"
            return
        fi
        printf "${green}passed${normal}\n"
        printf "> g++: "
        cp_compile "$2" b
        if [ $? -ne 0 ]; then
            printf "${red}failed${normal}\n"
            return
        fi
        printf "${green}compiled${normal}\n"
        long_separator
    fi

    if (( $# >= 3 )); then
        echo "${bold}Test generator${normal}: ${yellow}${3}${normal}"
        printf "> cppcheck: "
        cppcheck "$3" > /dev/null
        if [ $? -ne 0 ]; then
            printf "${red}failed${normal}\n"
            return
        fi
        printf "${green}passed${normal}\n"
        printf "> g++: "
        cp_compile "$3" c
        if [ $? -ne 0 ]; then
            printf "${red}failed${normal}\n"
            return
        fi
        printf "${green}compiled${normal}\n"

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
            printf "%s: ${red}${bold}FAILED${normal}. Ran in ${red}%.2f${normal} seconds.\n" ${i%.in} ${run_time}
            printf "> Expected:\t${green}%s${normal}\n" $(cat ${i%in}ok)
            printf "> Got:\t\t${red}%s${normal}\n" $(cat ${i%in}re)
        else
            printf "%s: ${green}${bold}PASSED${normal}. Ran in ${green}%.2f${normal} seconds.\n" ${i%.in} ${run_time}
            let passed++
        fi
        let tested++
    done

    long_separator
    echo "Passed ${passed}/${tested} tests."
    long_separator

    rm -f *.re
    rm -f a.out b.out c.out
}

cp_clean() {
    rm -f *.in
    rm -f *.ok
    rm -f *.re
}
