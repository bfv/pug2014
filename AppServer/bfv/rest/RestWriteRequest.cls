
using bfv.rest.RestRequest.

class bfv.rest.RestWriteRequest inherits RestRequest: 
  
  define public property Data as longchar no-undo get. set. 
  define public property Action as character no-undo get. set.
  
  
  method public void ProcessRequest(data as longchar):
    
/*    define variable parser*/
    
  end method.
  
  method public override character ToString():   
    return 
      super:ToString() + 
      substitute(
        ", action: &1, data: &2 ", 
        Action, 
        replace(substring(Data, 1, 30), "~n", " ")  + (if (length(Data) > 30) then "..." else "")
      ).
  end method.
  
end class.

