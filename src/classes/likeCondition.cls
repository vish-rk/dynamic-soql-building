public with sharing class likeCondition implements iSOQLFilterCondition{
    public String field;
    static Final String OPERATOR = '%';
    public String value;
    public enum LIKE_TYPE {STARTS_WITH, CONTAINS_WHOLE, ENDS_WITH, CONTAINS_EACH_WORD}
    public LIKE_TYPE likeType;

    public likeCondition(String f, String v, LIKE_TYPE lt){
        this.field = f;
        this.value = v;
        this.likeType = lt;
    }

    public String create(){
        String condition = this.field + ' ';
        String valueToCompare = String.escapeSingleQuotes(this.value);
        
        switch on this.likeType {
            when STARTS_WITH{
                condition += OPERATOR + valueToCompare;
            } 
            when CONTAINS_WHOLE{
                condition += OPERATOR + valueToCompare + OPERATOR;
            } 
            when ENDS_WITH{
                condition += valueToCompare + OPERATOR;
            }
            when else{
                condition = '';
            }
        }        
        return condition;
    }
}
