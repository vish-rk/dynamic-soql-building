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
                                    String sortOrder // Sort order
                                    ){
        String whereClause = buildWhere(filtersPayload); 
        String formedSOQL = String.format(soqlTemplate, new list<String>{sObjectName, fieldList, filtersPayload, sortField, sortOrder});
        return formedSOQL;
    }

    static String buildWhere(String filtersPayLoad){
        List<soqlFilterDTO> filters = (List<soqlFilterDTO>)JSON.deserialize(filtersPayload, List<soqlFilterDTO>.class);
        list<iSOQLFilterCondition> filterConditions = new list<iSOQLFilterCondition>();

        for(soqlFilterDTO filter : filters){
            switch on filter.type{
                when 'equals'{
                    filterConditions.add(new arithmaticCondition(filter.field, '=', filter.value));
                }
                when 'like_contains_each_word'{
                    filterConditions.add(new likeCondition(filter.field, filter.value, likeCondition.LIKE_TYPE.CONTAINS_WHOLE));
                }
                when 'set_contains'{
                    filterConditions.add(new setCondition(filter.field, filter.value.Split(',')));
                }
                when else{
                    throw new SoqlBuilderException('Invalid filter type is selected for where clause.');
                }
            }
        }
        String whereClause = '';
        for(iSOQLFilterCondition filter: filterConditions){
           whereClause += filter.create();
        }
        return whereClause;
    }
}