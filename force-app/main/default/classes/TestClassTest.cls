@IsTest
private class TestClassTest {
    @IsTest
    static void testAdd() {
        // Test case 1: Adding two positive numbers
        Decimal result1 = TestClass.add(10.5, 20.3);
        System.assertEquals(30.8, result1, 'The sum of 10.5 and 20.3 should be 30.8');
        
        // Test case 2: Adding a positive and a negative number
        Decimal result2 = TestClass.add(10.5, -5.3);
        System.assertEquals(5, result2, 'The sum of 10.5 and -5.3 should be 5.2');
        
        // Test case 3: Adding two negative numbers
        Decimal result3 = TestClass.add(-10.5, -20.3);
        System.assertEquals(-3.8, result3, 'The sum of -10.5 and -20.3 should be -30.8');
        
        // Test case 4: Adding zero
        Decimal result4 = TestClass.add(10.5, 0);
        System.assertEquals(10.5, result4, 'The sum of 10.5 and 0 should be 10.5');
    }
}