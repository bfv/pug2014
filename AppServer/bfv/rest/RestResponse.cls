 
using Progress.Json.ObjectModel.JsonObject.
using Progress.Json.ObjectModel.ObjectModelParser.

class bfv.rest.RestResponse: 
  
  define private variable jsonResponse as JsonObject no-undo.
  define private variable dataNode as JsonObject no-undo.
  
  
  constructor public RestResponse():
    jsonResponse = new JsonObject().  
  end.
  
  method public void AddData(data as longchar):
    addPropertyFromLongchar("data", data).
  end.
  
  
  method public void AddErrors(errorData as longchar):
    addPropertyFromLongchar("errors", errorData).
  end method.
  
  
  method public longchar GetResponseText():
    
    define variable responseString as longchar no-undo.
    
    jsonResponse:Write(input-output responseString).
    
    return string(responseString).
    
  end method.
  
  
  method private void addPropertyFromLongchar(propertyName as character, data as longchar):
    
    define variable parser as ObjectModelParser no-undo.
    define variable dataNodeExists as logical no-undo.
    
    
    parser = new ObjectModelParser().
    dataNode = cast(parser:Parse(data), JsonObject).
    dataNodeExists = jsonResponse:Has(propertyName).
    
    if (dataNodeExists) then
      jsonResponse:Set(propertyName, dataNode).
    else
      jsonResponse:Add(propertyName, dataNode).
    
  end method.
  
  
  method public override character ToString():
    
    define variable toString as longchar no-undo.
    
    jsonResponse:Write(input-output toString).
    
    return string(toString).
    
  end method.
  
end class.