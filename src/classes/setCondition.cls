public with sharing class setCondition implements iSOQLFilterCondition{
    public String field;
    Static final String SET_OPERATOR = 'IN';
    public list<Object> values;
  
    public String create(){
        Boolean stringType;
        String condition;

        if(!values.isEmpty())
            stringType = this.values[0] instanceOf String;
        
        if(stringType){
            list<String> sanitizedSOQLTxtValues = new List<String>();

            for(Object value : values){
                String txtVal = String.format('\' {0} \'', new List<String> {string.escapeSingleQuotes(String.valueOf(value))});
                sanitizedSOQLTxtValues.add(txtVal);
            }
            condition = SET_OPERATOR + '(' + String.join(sanitizedSOQLTxtValues, ',') + ')';
        } else {
            list<String> soqlNonStringValues = new list<String>();
            for(Object value : values){                
                soqlNonStringValues.add(string.escapeSingleQuotes(String.valueOf(value)));
            }
            condition = SET_OPERATOR + '(' + String.join(soqlNonStringValues, ',') + ')';
        }        

        return condition;
    }
}
