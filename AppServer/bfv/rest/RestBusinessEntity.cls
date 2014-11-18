
/* this class is the connection between the RestRouter and the implementation of IRestBackendConnector */
 
using bfv.rest.IRestBackendConnector from propath.
using bfv.rest.IRestRequest from propath.
using bfv.rest.RestDeleteRequest from propath.
using bfv.rest.RestReadRequest from propath.
using bfv.rest.RestResponse from propath.
using bfv.rest.RestWriteRequest from propath.
using bfv.oo.Factory.


class bfv.rest.RestBusinessEntity implements IRestRequest: 
   
  define protected property Resource as character no-undo get. protected set.
  define protected property DataResource as character no-undo get. protected set.
  
  define private property backend as IRestBackendConnector no-undo
    get:
      if (not valid-object(backend)) then
        backend = cast(Factory:GetInterface("bfv.system.IRestBackendConnector"), IRestBackendConnector).
      return backend.
    end. 
    private set.
   
  method public longchar ReadData(contextWeb as RestReadRequest):
    
    define variable hds as handle no-undo.
    define variable datasetString as longchar no-undo.
    
    ReadData(contextWeb, output dataset-handle hds).
    hds:get-buffer-handle(1):write-json("longchar", datasetString, true).
    
    return datasetString.
    
    finally:
      delete object hds no-error.
    end.
    
  end method.
  
  
  method public void ReadData(request as RestReadRequest, output dataset-handle hds): 
    
    /* To make generic usage of this class possible, the dataresource name is assumed to be
     * the resourcename + _data. */
     
    if (DataResource = "" or DataResource = ?) then
      DataResource = request:Resource + "_data".
      
    if (valid-handle(hds)) then
      backend:ReadData(DataResource, request, output dataset-handle hds by-reference).
    else
      backend:ReadData(DataResource, request, output dataset-handle hds).  /* if hds is not valid it can't be passed by-reference */
      
    finally:
      delete object hds no-error.  
    end.
    
  end method.
  
  method public longchar WriteData(request as RestWriteRequest):
    
    define variable hds as handle no-undo.
    define variable datasetString as longchar no-undo.
    define variable response as RestResponse no-undo.
    
    
    if (DataResource = "" or DataResource = ?) then
      DataResource = request:Resource + "_data".
      
    backend:WriteData(DataResource, request, output dataset-handle hds).
    hds:get-buffer-handle(1):write-json("longchar", datasetString, true).
    
    response = new RestResponse().
    response:AddData(datasetString).
    
    return response:GetResponseText().
    
    finally:
      delete object hds no-error.  
    end.
    
  end method.
  
  
  method public longchar DeleteData(request as RestDeleteRequest):
    
    define variable hds as handle no-undo.
    define variable datasetString as longchar no-undo.
    define variable response as RestResponse no-undo.
    
    
    if (DataResource = "" or DataResource = ?) then
      DataResource = request:Resource + "_data".
      
    backend:DeleteData(DataResource, request, output dataset-handle hds).
    hds:get-buffer-handle(1):write-json("longchar", datasetString, true).
    
    response = new RestResponse().
    response:AddData(datasetString).
    
    return response:GetResponseText().
    
  end method.

end class.