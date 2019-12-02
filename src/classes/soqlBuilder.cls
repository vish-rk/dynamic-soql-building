public with sharing class soqlBuilder {
    public soqlBuilder() {

    }

    public class SoqlBuilderException extends Exception{}
    
    public enum SORT_ORDER {ASCENDING, DESCENDING}

    static final String soqlTemplate = 'SELECT {0} FROM {1} WHERE {2} ORDER BY {3} {4}';

    public static string buildSOQL(String sObjectName, // sObject to be queried
                                    String fieldList, // comma separated field List
                                    String filtersPayload, //JSON payload filters for WHERE clause
                                    String sortField, // ORDER BY field
                                    SORT_ORDER sortOrder // Sort order
                                    ){
        String whereClause = buildWhere(filtersPayload); 
        String formedSOQL = String.format(soqlTemplate, new list<String>{fieldList, 
                                                                        sObjectName, 
                                                                        whereClause, 
                                                                        sortField, 
                                                                        sortOrder == SORT_ORDER.ASCENDING ? 'ASC': 'DESC'});
        return formedSOQL;
    }

    static String buildWhere(String filtersPayLoad){
        soqlFilterDTO filterDTO = (soqlFilterDTO)JSON.deserialize(filtersPayload, soqlFilterDTO.class);
        list<iSOQLFilterCondition> filterConditions = new list<iSOQLFilterCondition>();

        for(soqlFilterDTO.fieldFilter filter : filterDTO.fieldFilterVals){
            switch on filter.type{
                when 'equals'{
                    filterConditions.add(new arithmaticCondition(filter.field, '=', filter.value));
                }
                when 'like_contains_whole'{
                    filterConditions.add(new likeCondition(filter.field, filter.value, likeCondition.LIKE_TYPE.CONTAINS_WHOLE));
                }
                when 'set_contains'{
                    filterConditions.add(new setCondition(filter.field, 
                                                            new stringList(filter.value.Split(',')).trim()));
                }
                when else{
                    throw new SoqlBuilderException('Invalid filter type is selected for where clause.');
                }
            }
        }

        list<String> filterStrings = new list<String>();
        for(iSOQLFilterCondition filter: filterConditions){
           filterStrings.add(filter.create());  
        }
        String whereClause = String.format(filterDTO.filterLogic, filterStrings);
        return whereClause;
    }
}