public class NaturalNumberSequence {
    public static void main(String[] args) {
        int n = 99; // 生成したい自然数の範囲
        printNaturalNumbers(n);
    }

    public static void printNaturalNumbers(int n) {
        if (n <= 0) {
            return;
        }
        printNaturalNumbers(n - 1); // 再帰呼び出し
        System.out.print(n + " "); // 数を表示
    }
}
