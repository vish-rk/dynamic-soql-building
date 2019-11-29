public with sharing class setCondition implements iSOQLFilterCondition{
    public String field;
    Static final String SET_OPERATOR = 'IN';
    public list<Object> values;

    public setCondition(String f, List<Object> v){
        this.field = f;
        this.values = v;
    }
  
    public String create(){
        Boolean stringType;
        String condition;
        if(!this.values.isEmpty())
            condition = this.field + ' ';
        else 
            return null;

        switch on (this.values[0] instanceOf String ? 'String' : 'Other'){
            when 'String' {
                list<String> sanitizedSOQLTxtValues = new List<String>();

                for(Object value : values){
                    String txtVal = '\'' + string.escapeSingleQuotes(String.valueOf(value)) + '\'';
                    sanitizedSOQLTxtValues.add(txtVal);
                }
                condition += SET_OPERATOR + ' ' + '(' + String.join(sanitizedSOQLTxtValues, ',') + ')';
            }
            when else{
                list<String> soqlNonStringValues = new list<String>();
                for(Object value : values){                
                    soqlNonStringValues.add(string.escapeSingleQuotes(String.valueOf(value)));
                }
                condition += SET_OPERATOR + ' ' + '(' + String.join(soqlNonStringValues, ',') + ')';
            }
        }
       
        return condition;
    }
}
