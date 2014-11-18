/* this class reads config.xml and fill dsfactory */ 

class bfv.rest.FactoryDefinitionReader: 
  
  {bfv/rest/dsfactory.i &reference-only=reference-only}
  
  define private variable xmlDocument as handle no-undo.
  define private variable rootNode as handle no-undo.
  define private variable node as handle no-undo.
  define private variable attributeNode as handle no-undo.
  
  
  constructor public FactoryDefinitionReader():
    create x-document xmlDocument.
    create x-noderef rootNode.
    create x-noderef node.
    create x-noderef attributeNode.
  end.
  
  destructor FactoryDefinitionReader():
    delete object xmlDocument no-error.
    delete object rootNode no-error.
    delete object node no-error.
    delete object attributeNode no-error.
  end.
  
  method public void ReadDefinitions(resourceFile as character, dataset dsfactory):
    
    define variable numChildNodes as integer no-undo.
    define variable i as integer no-undo.
    
    resourceFile = search(resourceFile).
    
    xmlDocument:load("file", resourceFile, true).
    xmlDocument:get-document-element(rootNode).
    numChildNodes = rootNode:num-children.
    
    do i = 1 to numChildNodes:
      rootNode:get-child(node, i).
      if (node:subtype = "element") then do:
        
        case node:name:
          when "interface" then 
            processInterfaceNode(node).
          
          when "resource" then
            processResourceNode(node).
        end case.
        
      end.
    end.
    
  end method.
  
  method private void processInterfaceNode(resourceNode as handle):
    create ttinterface.
    processNode(resourceNode, buffer ttinterface:handle).
  end method.
  
  method private void processResourceNode(resourceNode as handle):
    create ttresource.
    processNode(resourceNode, buffer ttresource:handle).
  end method.
  
  method private void processNode(node as handle, bufferHandle as handle):
    node:get-attribute-node(attributeNode, "name").
    bufferHandle::name = attributeNode:node-value.
    node:get-attribute-node(attributeNode, "implementation").
    bufferHandle::implementation = attributeNode:node-value.
  end method.
  
end class.