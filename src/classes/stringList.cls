global class stringList implements Iterator<String>{ 

    List<String> vals {get; set;} 
    Integer i {get; set;} 
    
    public class StringIteratorException extends Exception{}

    public stringList(list<String> vals){ 
       this.vals = vals;
    }      

    global boolean hasNext(){ 
       if(i >= vals.size()) {
           return false; 
       } else {
           return true; 
       }
    }    

    global String next(){      
       if(i == vals.size())
           return null; 
       i++; 
       return vals[i-1]; 
    }
   
    global list<String> trim(){
        if(this.vals == null || this.vals.isEmpty()) 
            throw new StringIteratorException('Input list is empty. Can not iterate.');
        
        list<String> trimmed = new list<String>();
        for(String val : this.vals){
            trimmed.add(val.trim());            
        }
        return trimmed;
    }
}