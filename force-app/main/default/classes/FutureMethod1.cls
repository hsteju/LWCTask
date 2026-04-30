public class FutureMethod1 {
    public FutureMethod1() { // Constructor
        System.debug('I am in FutureMethod1 Constructor method');
        method1();
        method2();
        method3();
        //method4();
        method5();
    }
	
    public void method1() {
        System.debug('method1');
    }
    public void method2() {
        System.debug('method2');
        method4();
    }
    public static void method3() {
        System.debug('method3');
    }
	@future
    public static void method4() {
        System.debug('method4');
        
    }
	@future
    public static void method5() {
        System.debug('method5');
    }
}