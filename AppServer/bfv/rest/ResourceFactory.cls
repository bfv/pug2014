
using bfv.rest.FactoryDefinitionReader. 
using bfv.rest.ResourceFactory.
using Progress.Lang.AppError from propath.


class bfv.rest.ResourceFactory: 
  
  {bfv/rest/dsfactory.i}
    
  define private variable factoryInitialized as logical no-undo.
  
  
  constructor public ResourceFactory():
    this-object("config/factory.xml").
  end.
  
  constructor public ResourceFactory(resoureFile as character):
    if (not factoryInitialized) then
      readResourceDefinitions(resoureFile).
  end.
    
  method public Progress.Lang.Object GetResource(resourceName as character):
    find ttresource where ttresource.name = resourceName no-error.
    if (available(ttresource)) then
      return GetInstance(ttresource.implementation).
    else 
      undo, throw new AppError(substitute("Factory: resourse '&1' not found", resourceName), -1).
  end method.
  
  
  method public Progress.Lang.Object GetInterface(interfaceName as character):
    find ttinterface where ttinterface.name = interfaceName no-error.
    if (available(ttinterface)) then
      return GetInstance(ttinterface.implementation).
    else 
      undo, throw new AppError(substitute("Factory: interface '&1' not found", interfaceName), -1).
  end method.
  
    
  method private void readResourceDefinitions(resourceFile as character):
    
    define variable reader as FactoryDefinitionReader no-undo.
    
    reader = new FactoryDefinitionReader().
    reader:ReadDefinitions(resourceFile, dataset dsfactory by-reference).
    
  end method.
  
  
  method private Progress.Lang.Object GetInstance(className as character):
    
    define variable obj as Progress.Lang.Object no-undo.
    
    /* here's the place to provide for other Factory behavior, like singeltons.
     * for now we're just instantiating the resource */
    
    obj = dynamic-new (className)().
    return obj.
    
  end method.
  
end class.