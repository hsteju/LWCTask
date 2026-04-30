trigger Assignment31 on Contact (after insert, after delete, after undelete) {
    Set<Id> accountIds = new Set<Id>();
    if (Trigger.isInsert || Trigger.isUndelete) {
        for (Contact con : Trigger.new) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    if (Trigger.isDelete) {
        for (Contact con : Trigger.old) {
            if (con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
    }

    Map<Id, Integer> accountContactCountMap = new Map<Id, Integer>();

    for (AggregateResult ar : [
        SELECT AccountId, COUNT(Id) contactCount
        FROM Contact
        WHERE AccountId IN :accountIds
        GROUP BY AccountId
    ]) {
        accountContactCountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('contactCount'));
    }

    List<Account> accountsToUpdate = new List<Account>();

    for (Id accountId : accountIds) {
        Account acc = new Account(Id = accountId);
        acc.Count_of_Contacts__c = accountContactCountMap.containsKey(accountId) ? accountContactCountMap.get(accountId) : 0;
        accountsToUpdate.add(acc);
    }

    if (!accountsToUpdate.isEmpty()) {
        update accountsToUpdate;
    }
}