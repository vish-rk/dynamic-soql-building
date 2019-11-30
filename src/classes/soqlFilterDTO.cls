public with sharing class soqlFilterDTO {
   
    public String filterLogic;
    public list<fieldFilter> fieldFilterVals;

    public soqlFilterDTO(String filterLogic, list<fieldFilter> fieldFilterVals) {
       this.filterLogic = filterLogic;
       this.fieldFilterVals = fieldFilterVals;
    }

    public class fieldFilter{
        public String sno;
        public String type;
        public String field;
        public String value;
        public fieldFilter(String sno, String type, String field, String value) {
            this.sno = sno;
            this.type = type;
            this.field = field;
            this.value = value;
        }
    }

    public static soqlFilterDTO deserialize(String jsonPayLoad){
        return (soqlFilterDTO)Json.deserialize(jsonPayLoad, soqlFilterDTO.class);
    }
}