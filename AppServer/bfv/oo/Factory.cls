 
using bfv.rest.ResourceFactory.
using bfv.rest.IRestRequest.


class bfv.oo.Factory: 
  
  define protected static variable factory as ResourceFactory no-undo.
  
  constructor static Factory():
    factory = new ResourceFactory().
  end.
  
  method public static Progress.Lang.Object GetResource(resourceName as character):
    return factory:GetResource(resourceName).
  end method.
  
  
  method public static Progress.Lang.Object GetInterface(interfaceName as character):
    return factory:GetInterface(interfaceName).
  end method.
  
  
  method public static IRestRequest GetRestReader(resourceName as character):
    return cast(GetResource(resourceName), IRestRequest).  
  end method.
  
  method public static IRestRequest GetRestWriter(resourceName as character):
    return cast(GetResource(resourceName), IRestRequest).  
  end method.

  method public static IRestRequest GetRestDeleter(resourceName as character):
    return cast(GetResource(resourceName), IRestRequest).  
  end method.

end class.