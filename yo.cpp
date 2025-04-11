#include<bits/stdc++.h>
using namespace std;

using ll = long long;

const int N = 1e5 + 10;

ll n, k, x;
ll a[N];


int main() {
    ios::sync_with_stdio(false); cin.tie(0); cout.tie(0);
    int t;
    cin >> t;
    while (t--) {
        cin >> n >> k >> x;
        ll sum = 0;
        for (int i = 0; i < n; i++) cin >> a[i];
        for (int i = 0; i < n; i++) sum += a[i];
        
        ll total_sum = sum * k;

        if (x > total_sum) {
            cout << 0 << endl;
        }

        else if (sum > x) {
            ll target = 0, pos;

            for (int i = 0; i < n; i++) {
                target += a[i];
                if (target >= x) {
                    pos = i;
                    break;
                }
            }
            cout << (n - pos) + ( n * (k - 1)) << endl;
        }

        else if (sum < x) {
            ll num_time, pos, target;
            
            if (!(x % sum)) cout << (n * k) - ((x / sum) * n) << endl;
            else {
                num_time = x / sum;
                target = num_time * sum;
                // cout << target << endl;
                for (int i = 0; i < n; i++) {
                    target += a[i];
                    if (target >= x) {
                        pos = i;
                        break;
                    }
                }
                ll total = n * k;
                ll req = (num_time * n) + pos;

                cout << (total - req) + 1 << endl;
            }
        }

        else if (sum == x) {
            cout << k<< endl;
        }
    }
    return 0;
}