
using Progress.Lang.*.

interface pug.generic.IAppBusinessEntity:  
  
  define public property DatasetHandle as handle no-undo get.
  
  method public void ReadData(id as character, output dataset-handle dsData).
  method public void DeleteData(id as character).
  method public void CreateData(output dataset-handle dsData).
  method public void UpdateData(output dataset-handle dsData).
  
end interface.