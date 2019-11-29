public with sharing class soqlFilterDTO {
    public String sno;
    public String type;
    public String field;
    public String value;

    public soqlFilterDTO(String sno, String type, String field, String value) {
        this.sno = sno;
        this.type = type;
        this.field = field;
        this.value = value;
    }

    public static list<soqlFilterDTO> deserialize(String jsonPayLoad){
        return (list<soqlFilterDTO>)Json.deserialize(jsonPayLoad, list<soqlFilterDTO>.class);
    }
}
