// test.sy
#include "sylib.h" 

int cal_sum(int n) {
    int i;
    int sum;
    i = 1;
    sum = 0;
    while (i <= n) {
        sum = sum + i;
        i = i + 1;
    }
    return sum;
}

int main() {
    int n;
    n = getint();
    int result;
    result = cal_sum(n);
    putint(result);
    return 0;
}