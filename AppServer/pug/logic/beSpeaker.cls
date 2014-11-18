 
using pug.generic.IAppBusinessEntity.

block-level on error undo, throw.


class pug.logic.beSpeaker implements IAppBusinessEntity: 
  
  {pug/logic/dsspeaker.i}
  
  define public property DatasetHandle as handle no-undo get. private set.
  
  constructor public beSpeaker():
    DatasetHandle = dataset dsspeaker:handle.
  end.
  
  method public void ReadData(id as character, output dataset-handle dsData):
    
    dataset dsspeaker:empty-dataset().
    
    for each pugspeaker where (if id > "" then pugspeaker.speaker_id = integer(id) else true) no-lock:
      
      create ttspeaker.
      buffer-copy pugspeaker to ttspeaker
      assign 
        ttspeaker.id = pugspeaker.speaker_id
        .
          
    end.
    
    dsData = dataset dsspeaker:handle.
    
    finally:
      delete object dsData no-error.
    end.
      
  end method.
  
  method public void DeleteData(id as character):
    
    for first pugspeaker where pugspeaker.speaker_id = integer(id) exclusive-lock:
      delete pugspeaker.
    end.
    
  end method.
  
  method public void CreateData(output dataset-handle dsData):
    
    updateDataStatic("create", output dataset-handle dsdata by-reference).
    
    finally:
      delete object dsData no-error.
    end.
    
  end.
  
  method public void UpdateData(output dataset-handle dsData):
    
    updateDataStatic("update", output dataset-handle dsdata by-reference).
    
    finally:
      delete object dsData no-error.
    end.
    
  end.
    
  method private void updateDataStatic(action as character, output dataset dsspeaker):
    
    for each ttspeaker:
      
      find pugspeaker where pugspeaker.speaker_id = ttspeaker.id exclusive-lock no-error.
      if (not available(pugspeaker)) then
        create pugspeaker.
        
      buffer-copy ttspeaker to pugspeaker.
      if (action = "create") then
        assign pugspeaker.speaker_id = ttspeaker.id.
      
    end.
    
  end method.
  
end class.