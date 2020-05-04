/**
 * Class TriggerFactory
 *
 * Used to instantiate and execute Trigger Handlers associated with sObjects.
 */
public with sharing class TriggerFactory
{
	/**
	 * private static method to control the execution of the handler
	 *
	 * Arguments:	ITrigger handler - A Trigger Handler to execute
	 */	
	public static void execute(ITrigger handler)
	{
		// Before Trigger
		if (Trigger.isBefore)
		{
			// Call the bulk before to handle any caching of data and enable bulkification
			handler.bulkBefore();
			
			// Iterate through the records to be deleted passing them to the handler.
			if (Trigger.isDelete)
			{
				for (SObject so : Trigger.old)
				{
					handler.beforeDelete(so);
				}
			}
			// Iterate through the records to be inserted passing them to the handler.
			else if (Trigger.isInsert)
			{
				for (SObject so : Trigger.new)
				{
					handler.beforeInsert(so);
				}
			}
			// Iterate through the records to be updated passing them to the handler.
			else if (Trigger.isUpdate)
			{
				for (SObject so : Trigger.old)
				{
					handler.beforeUpdate(so, Trigger.newMap.get(so.Id));
				}
			}
		}
		else
		{
			// Call the bulk after to handle any caching of data and enable bulkification
			handler.bulkAfter();
			
			// Iterate through the records deleted passing them to the handler.
			if (Trigger.isDelete)
			{
				for (SObject so : Trigger.old)
				{
					handler.afterDelete(so);
				}
			}
			// Iterate through the records inserted passing them to the handler.
			else if (Trigger.isInsert)
			{
				for (SObject so : Trigger.new)
				{
					handler.afterInsert(so);
				}
			}
			// Iterate through the records updated passing them to the handler.
			else if (Trigger.isUpdate)
			{
				for (SObject so : Trigger.old)
				{
					handler.afterUpdate(so, Trigger.newMap.get(so.Id));
				}
			}
		}
		
		// Perform any post processing
		handler.andFinally();
	}
}
