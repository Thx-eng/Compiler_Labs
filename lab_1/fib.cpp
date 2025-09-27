#include <iostream> // 用于cout和cin

// 使用标准命名空间
using namespace std;

// 主函数入口
int main() {
    int a, b, t, n;
    int i; // 循环计数器

    // 初始化斐波那契数列的前两项
    a = 0;
    b = 1;
    i = 1;

    cout << "请输入你想要的斐波那契数列的项数: ";
    cin >> n;

    // 打印初始的两项
    cout << "斐波那契数列第 0 项: " << a << endl;
    cout << "斐波那契数列第 1 项: " << b << endl;

    // 循环生成并打印后续项
    while (i < n) {
        t = b;
        b = a + b;
        cout << "斐波那契数列第 " << i + 1 << " 项: " << b << endl;
        a = t;
        i = i + 1;
    }

    return 0; // main函数应该返回一个整数
}