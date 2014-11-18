using bfv.oo.Factory from propath. 
using bfv.rest.RestReadRequest from propath.
using bfv.rest.IRestRequest from propath.
using bfv.rest.RestWriteRequest from propath.
using bfv.rest.RestDeleteRequest from propath.

@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
class bfv.rest.RestRouter: 
    
  @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
  method public character GetResource(resource as character, id as character, output resultData as longchar):
    
    define variable context as RestReadRequest no-undo.
    define variable returnValue as character no-undo.
    define variable reader as IRestRequest no-undo.
    
    
    message substitute("***** GET resource: '&1', id: '&2'", resource, id).
    
    do on error undo, throw:
      
      context = new RestReadRequest().
      assign 
        context:Resource = resource
        context:Id = id
        .
      
      reader = Factory:GetRestReader(resource).
      resultData = reader:ReadData(context).
      
      catch err1 as Progress.Lang.Error:
        return "500".        
      end catch.
      
    end.
    
    return "200".
    
  end method.
  
  @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
  method public character GetResources(resource as character, output resultData as longchar):
    return this-object:GetResource(resource, ?, output resultData).
  end.
  
  @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
  method public character PutResource(resource as character, data as longchar, output resultData as longchar):

    define variable writer as IRestRequest no-undo.
    define variable requestData as RestWriteRequest no-undo.
    
    message substitute("***** PUT resource: '&1'", resource).
        
    do on error undo, throw:
      
      writer = Factory:GetRestWriter(resource).
      requestData = new RestWriteRequest().
      assign 
        requestData:Resource = resource
        requestData:Data = data
        requestData:Action = "update"
        .
      
      resultData = writer:WriteData(requestData).
      
      catch err1 as Progress.Lang.Error:
        message substitute("error: &1", err1:GetMessage(1)).
        return "500".        
      end catch.
      
    end.  
      
    return "200".
    
  end method.
  
  @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
  method public character PostResource(resource as character, data as longchar, output resultData as longchar):
    
    define variable writer as IRestRequest no-undo.
    define variable requestData as RestWriteRequest no-undo.
    
    message substitute("***** POST resource: '&1'", resource).
        
    do on error undo, throw:
      
      writer = Factory:GetRestWriter(resource).
      requestData = new RestWriteRequest().
      assign 
        requestData:Resource = resource
        requestData:Data = data
        requestData:Action = "create"
        .
      
      resultData = writer:WriteData(requestData).
      
      catch err1 as Progress.Lang.Error:
        message substitute("error: &1", err1:GetMessage(1)).
        return "500".        
      end catch.
      
    end.  
      
    return "200".
    

  end method.
  
  @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
  method public character DeleteResource(resource as character, id as character, output resultData as longchar):

    define variable deleter as IRestRequest no-undo.
    define variable context as RestDeleteRequest no-undo.
    
    message substitute("***** DELETE resource: '&1', id: '&2'", resource, id).    

    do on error undo, throw:
          
      deleter = Factory:GetRestDeleter(resource).

      context = new RestDeleteRequest().
      assign 
        context:Resource = resource
        context:Id = id
        .
        
      resultData = deleter:DeleteData(context).
      if (resultData = ? or resultData = "") then
        resultData = "~{}".
    
      catch err1 as Progress.Lang.Error:
        message err1:GetMessage(1).
        return "500".        
      end catch.
      
    end.

    return "200".

  end method.
  
end class.