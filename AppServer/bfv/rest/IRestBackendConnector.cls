
using bfv.rest.RestReadRequest.
using bfv.rest.RestWriteRequest.
using bfv.rest.RestDeleteRequest.

interface bfv.rest.IRestBackendConnector:  
  
  method public void ReadData(dataResource as character, readRequest as RestReadRequest, output dataset-handle datasetHandle).
  method public void WriteData(dataResource as character, writeRequest as RestWriteRequest, output dataset-handle datasetHandle).
  method public void DeleteData(dataResource as character, deleteRequest as RestDeleteRequest, output dataset-handle datasetHandle).
  
end interface.