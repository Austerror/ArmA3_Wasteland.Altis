private ["_save","_delete"];
_delete =
"
	deleteFromDB = _this;
	publicVariableServer 'deleteFromDB';
";

fn_DeleteFromDB = compile _delete;
_save =
"
	accountToServerSave = _this;
	publicVariableServer 'accountToServerSave';
";

fn_SaveToServer = compile _save;
