trigger AccountTrigger on Account (after delete, after insert, after update, before delete, before insert, before update)
{
	TriggerFactory.execute(new AccountHandler());
}
