
/* the temp-tables from storing the contents of config.xml */

define temp-table ttresource no-undo
  {&reference-only}
  field name as character 
  field implementation as character
  .

define temp-table ttinterface no-undo
  {&reference-only}
  field name as character
  field implementation as character
  .

define dataset dsfactory 
  {&reference-only}
  for ttinterface, ttresource
  .

