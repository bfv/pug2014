
define {&scope} temp-table ttspeaker no-undo
  serialize-name "speaker"
  before-table btspeaker
  {&reference-ony}
  field id as integer
  field firstname as character
  field lastname as character 
  field birthdate as date
  .
  
define dataset dsspeaker 
  serialize-name "speakers"
  for ttspeaker
  .