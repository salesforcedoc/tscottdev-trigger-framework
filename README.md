# tscottdev-trigger-framework

I reference this framework from time to time and thought it might be handy to create a repo for [Tony Scott's](https://github.com/tscottdev) 2013 code recipe, [Trigger Pattern for Tidy, Streamlined, Bulkified Triggers](https://developer.secure.force.com/cookbook/recipe/trigger-pattern-for-tidy-streamlined-bulkified-triggers).

Basic usage:

```apex
class ObjectHandler implements ITrigger {
    public bulkBefore() {
        if (Trigger.isDelete) { /* do some bulk stuff before delete: collect additional data,  */ }
    }
    public bulkAfter() {}
    public beforeInsert(SObject so) { /* do some ops with individual records (no SOQL or DML recommended! */ }
    public beforeUpdate(SObject oldSo, SObject so) {}
    public beforeDelete(SObject so) {}
    public afterInsert(SObject so) {}
    public afterUpdate(SObject oldSo, SObject so) {}
    public afterDelete(SObject so) {}
    public andFinally() { /* any post processing */ }
}

trigger ObjectTrigger on SObject (after delete, after insert, after update, before delete, before insert, before update)
{
	TriggerFactory.execute(new ObjectHandler());
}
```
