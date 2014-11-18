 
block-level on error undo, throw.

using bfv.rest.RestReadRequest from propath.
using bfv.rest.RestDeleteRequest from propath.
using bfv.rest.RestWriteRequest from propath.

interface bfv.rest.IRestRequest: 
  
  method public longchar ReadData(context as RestReadRequest).
  method public longchar DeleteData(context as RestDeleteRequest).
  method public longchar WriteData(context as RestWriteRequest).
  
end interface.