#include <stdio.h>
#include <stdlib.h>

float sqrt_min(float x) {
    // Approximate the square root of x
    float guess = 1.0;
    int iter = 10;
    while (iter) {
        float quot = x / guess;
        guess = 0.5 * (guess + quot);
        iter = iter - 1;
    }
    printf("%f\n", guess);
    printf("%f\n", guess * guess);
    return guess;
}

int gcd(int m, int n) {
    if (m == 0 && n == 0) return 0;
    if (m < 0) m = -m;
    if (n < 0) n = -n;
    if (m == 0) return n;
 
    int divisor = 1;
    int a = 1;

    while (a <= m) {
        int m2 = m;
        int m_mod_a = 0;
        int n2 = n;
        int n_mod_a = 0;

        while (m2 >= a) m2 = m2 - a;
        while (n2 >= a) n2 = n2 - a;

        if (m2 == 0 && n2 == 0) divisor = a;
        a = a + 1;
    }
 
    return divisor;
}

int main() {
    sqrt_min(2500);
    printf("%d\n", gcd(100, 169));
    return EXIT_SUCCESS;
}
