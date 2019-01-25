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
    else {
        if (m == 0) return n;
        else {
            if (m < 0) m = -m;
            if (n < 0) n = -n;
        
            int divisor = 1;
            int a = 1;

            while (a <= m) {
                int m_mod_a_rem = m;
                int n_mod_a_rem = n;

                while (m_mod_a_rem >= a) m_mod_a_rem = m_mod_a_rem - a;
                while (n_mod_a_rem >= a) n_mod_a_rem = n_mod_a_rem - a;

                if (m_mod_a_rem == 0 && n_mod_a_rem == 0) divisor = a;
                a = a + 1;
            }
        
            return divisor;
        }
    }
}

int main() {
    sqrt_min(2500);
    printf("%d\n", gcd(100, 170));
    return EXIT_SUCCESS;
}
