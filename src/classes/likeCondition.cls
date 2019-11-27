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
        String condition;
        String valueToCompare = String.escapeSingleQuotes(this.value);
        System.debug('>>>>>>>>>> ' + this.likeType);
        if(this.likeType == LIKE_TYPE.STARTS_WITH){
            condition = OPERATOR + valueToCompare;
        } else if(this.likeType == LIKE_TYPE.CONTAINS_WHOLE){
            condition = OPERATOR + valueToCompare + OPERATOR;
        } else if(this.likeType == likeCondition.LIKE_TYPE.ENDS_WITH){
            condition = valueToCompare + OPERATOR;
        }

        return condition;
    }
}
