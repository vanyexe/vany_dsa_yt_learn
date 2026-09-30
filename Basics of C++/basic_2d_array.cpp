#include <bits/stdc++.h>
using namespace std;

// 2D array

int main() {
    int arr[2][4];  // 2 x 4 boxes

    arr[2][2] = 8;
    cout << arr[2][2];


    // for the values which we have didn't defines they will give garbage value everytime
    // for ex:
    // arr[1][2] = 10;
    // cout << arr[2][3];

    return 0;
}