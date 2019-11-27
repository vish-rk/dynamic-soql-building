public with sharing class arithmaticCondition implements iSOQLFilterCondition {
    
    public String field;
    public String operator;
    public Object value;

    public arithmaticCondition(String f, String o, Object v){
        this.field = f;
        this.operator = o;
        this.value = v;
    }

    public String create(){
        String condition;
        String santizedInput = string.escapeSingleQuotes(string.valueOf(this.value));
        if(this.value instanceOf String)
            condition = String.format('{0} {1} {2}', new list<String> { this.field, 
                                                                        this.operator, 
                                                                        '\'' + santizedInput + '\''});
        else
            condition = String.format('{0} {1} {2}', new list<String> { this.field, 
                                                                        this.operator, 
                                                                        santizedInput });
        return condition;
    }
}
