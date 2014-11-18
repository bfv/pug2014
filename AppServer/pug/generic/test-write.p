
using bfv.rest.RestRouter from propath.

define variable router as RestRouter no-undo.
define variable dataIn as longchar no-undo.
define variable dataOut as longchar no-undo.

copy-lob file "c:/tmp/restwriteinput.txt" to dataIn.

router = new RestRouter().
router:PostResource("speaker", dataIn, output dataOut).

message string(dataOut). 