public class Assignment23 implements System.Schedulable {
    public void execute(System.SchedulableContext SC) {
        assignment22 batch = new assignment22();
        Database.executeBatch(batch, 200); // Adjust batch size as needed
    }
}