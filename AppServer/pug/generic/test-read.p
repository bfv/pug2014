using bfv.rest.RestRouter from propath.

define variable router as RestRouter no-undo.
define variable dataOut as longchar no-undo.

router = new RestRouter().
router:GetResource("speaker", "1", output dataOut).

message string(dataOut). 