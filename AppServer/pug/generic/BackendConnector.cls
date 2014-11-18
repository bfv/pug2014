 
using pug.generic.IAppBusinessEntity from propath.
using bfv.rest.IRestBackendConnector from propath.
using bfv.oo.Factory from propath. 


block-level on error undo, throw.

class pug.generic.BackendConnector implements IRestBackendConnector: 

  method public void ReadData(dataResource as character, readRequest as bfv.rest.RestReadRequest, output dataset-handle datasetHandle ):
    
    define variable be as IAppBusinessEntity no-undo.
    
    be = cast(Factory:GetResource(dataResource), IAppBusinessEntity).
    be:ReadData(readRequest:Id, output dataset-handle datasetHandle by-reference).
    
  end method.


	method public void DeleteData(dataResource as character, deleteRequest as bfv.rest.RestDeleteRequest, output dataset-handle datasetHandle):
		
    define variable be as IAppBusinessEntity no-undo.
    
    be = cast(Factory:GetResource(dataResource), IAppBusinessEntity).
		be:DeleteData(deleteRequest:Id).
		
		datasetHandle = ?.

	end method.

	method public void WriteData(dataResource as character, writeRequest as bfv.rest.RestWriteRequest, output dataset-handle datasetHandle ):
		
    define variable be as IAppBusinessEntity no-undo.
    
    be = cast(Factory:GetResource(dataResource), IAppBusinessEntity).

    create dataset datasetHandle.
    datasetHandle:create-like(be:DatasetHandle).
    datasetHandle:get-buffer-handle(1):read-json("longchar", writeRequest:Data).
   
    if (writeRequest:Action = "create") then
      be:CreateData(output dataset-handle datasetHandle by-reference).
    else 
      be:UpdateData(output dataset-handle datasetHandle by-reference).
      
	end method.

end class.