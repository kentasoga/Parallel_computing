#include <stdio.h>
#include <time.h>

#define N 4096

int  a[N][N], b[N][N];

int main(void){
	int i, j;
	clock_t start, end;

	for ( i = 0; i < N; i++){
		for ( j = 0; j < N; j++){
			a[i][j] = 1;
			b[i][j] = 0;
		}
	}

	start = clock();
	for ( i = 0; i < N; i++){
		for ( j = 0; j < N; j++){
			b[i][j] = a[i][j];
		}
	}
	end = clock();
	printf ("%f [sec]\n", (double)(end-start)/CLOCKS_PER_SEC);

	start = clock();
	for ( i = 0; i < N; i++){
		for ( j = 0; j < N; j++){
			b[j][i] = a[j][i];
		}
	}
	end = clock();
	printf ("%f [sec]\n", (double)(end-start)/CLOCKS_PER_SEC);

	return 0;

}
