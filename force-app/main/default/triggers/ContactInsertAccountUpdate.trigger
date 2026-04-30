trigger ContactInsertAccountUpdate on Contact (before insert ) {
    for(contact con :trigger.new)
    {
        if(String.isBlank(con.Title))
        {
            con.Title = 'customer';
        }
    }
	
}