// Get the profileNamespace Radio Settings variables
_baseRadios = profileNamespace getVariable ["radios_base", []];
_channels = profileNamespace getVariable ["radios_channel", []];
_volumes = profileNamespace getVariable ["radios_volume", []];
_spatials = profileNamespace getVariable ["radios_spatial", []];
_pttAssignment = profileNamespace getVariable ["ptt_assignment", []];

// Check if previous settings exist
if (_baseRadios isEqualTo []) then {
	// If not
    hint "There are no saved settings.";
} else {
    // Create a formatted string with the radio information and the Push To Talk assignment and Display as hint
_hintString = format ["SAVED RADIO SETTINGS\n\n"];
    {
        _index = _forEachIndex;
        _baseRadio = (_baseRadios select _index) splitString "_" joinString " " select [4];
        _hintString = _hintString + format ["Radio %1:%2\nChannel: %3\nVolume: %4\nSpatial: %5\n\n", _index + 1, _baseRadio, _channels select _index, _volumes select _index, _spatials select _index];
    } forEach _baseRadios;

	_pttString = "";
	{
	    if (_forEachIndex < 3) then {
        	_formattedRadio = _x splitString "_" joinString " " select [4];
        	_formattedRadio = toUpper _formattedRadio;
        	_idParts = _formattedRadio splitString "ID";
        	_formattedRadio = _idParts select 0;
        	_pttString = _pttString + format ["PTT%1: %2\n", _forEachIndex + 1, _formattedRadio];
	    };
	} forEach _pttAssignment;

_hintString = _hintString + _pttString;
hint _hintString;
}