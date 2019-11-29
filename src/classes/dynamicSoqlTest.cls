@isTest
public with sharing class dynamicSoqlTest {
    @isTest
    public static void testFilterCreation() {
        list<iSOQLFilterCondition> conditions = new list<iSOQLFilterCondition>();
        conditions.add(new arithmaticCondition('Id','=', 101));
        conditions.add(new likeCondition('Name', 'Vishnu', likeCondition.LIKE_TYPE.CONTAINS_WHOLE)); 
        conditions.add(new setCondition('Skills', new list<Object>{'SFDC', 'Mule'}));

        for(iSOQLFilterCondition condition: conditions){
            System.debug('>>>>>>>>>>>>>>'+ condition.create());
        }
    }
}
