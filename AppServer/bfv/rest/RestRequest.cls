 

class bfv.rest.RestRequest: 

  define public property Resource as character no-undo get. set.
  define public property DataResource as character no-undo get. set.
  define public property ResourceBufferName as character no-undo get. set.
  define public property ResourceDatasetName as character no-undo get. set.
  
  method public override character ToString(): 
    return substitute("resource: '&1'", Resource).
  end method.

end class.