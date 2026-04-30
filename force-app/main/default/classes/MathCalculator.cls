public class MathCalculator {

    private static Integer add(Integer a, Integer b) {
        return a + b;
    }

    private static Integer multiply(Integer a, Integer b) {
        return a * b;
    }

    private static void printOutput(String operation, Integer result) {
        System.debug(operation + ' result = ' + result);
    }

    public void doMath(Integer num1, Integer num2) {
        Integer sum = add(num1, num2);
        printOutput('Addition', sum);

        Integer product = multiply(num1, num2);
        printOutput('Multiplication', product);
    }
}