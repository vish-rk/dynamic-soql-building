public with sharing class likeCondition implements iSOQLFilterCondition{
    public enum LIKE_TYPE {STARTS_WITH, CONTAINS_WHOLE, ENDS_WITH, CONTAINS_EACH_WORD}

    public String field;
    static Final String OPERATOR = 'LIKE';
    static Final String WILD_CARD = '%';
    public String value;    
    public LIKE_TYPE likeType;

    public likeCondition(String f, String v, LIKE_TYPE lt){
        this.field = f;
        this.value = v;
        this.likeType = lt;
    }

    public String create(){
        String condition = this.field + ' ' + OPERATOR + ' ';
        String valueToCompare = String.escapeSingleQuotes(this.value); // Handle SOQL injection.
        
        switch on this.likeType {
            when STARTS_WITH{
                condition += '\'' + WILD_CARD + valueToCompare + '\'';
            } 
            when CONTAINS_WHOLE{
                condition += '\'' + WILD_CARD + valueToCompare + WILD_CARD + '\'';
            } 
            when CONTAINS_EACH_WORD{
                String spaceMatcher = '\\s+';
                condition += '\'' + WILD_CARD + valueToCompare.replaceAll(spaceMatcher, WILD_CARD) + WILD_CARD + '\'';
            }
            when ENDS_WITH{
                condition += valueToCompare + WILD_CARD + '\'';
            }
            when else{
                condition = '';
            }
        }        
        return condition;
    }
}