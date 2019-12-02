@isTest
public with sharing class dynamicSoqlTest {
    @isTest
    public static void testFilterCreation() {
        soqlFilterDTO filterDTO = new soqlFilterDTO();
        filterDTO.filterLogic = '{0} AND {1} AND {2}';
        filterDTO.fieldFilterVals = new list<soqlFilterDTO.fieldFilter>{new soqlFilterDTO.fieldFilter('1', 'equals', 'Id', '101'),
                                                                        new soqlFilterDTO.fieldFilter('2', 'like_contains_whole', 'Name', 'vishnu'),
                                                                        new soqlFilterDTO.fieldFilter('3', 'set_contains', 'Skills__c', 'Mule, SFDC')};
        
        String filtersPayload = JSON.serialize(filterDTO);
        System.assertEquals('SELECT Id, Name FROM Account WHERE Id = \'101\' AND Name LIKE \'%vishnu%\' AND Skills__c IN (\'Mule\',\'SFDC\') ORDER BY Name ASC',
                            soqlBuilder.buildSOQL('Account', 'Id, Name', filtersPayload, 'Name', soqlBuilder.SORT_ORDER.ASCENDING));
    }
}