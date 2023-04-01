// Get the profileNamespace Radio Settings variables
_baseRadios = profileNamespace getVariable ["radios_base", []];
_channels = profileNamespace getVariable ["radios_channel", []];
_volumes = profileNamespace getVariable ["radios_volume", []];
_spatials = profileNamespace getVariable ["radios_spatial", []];

// Check if previous settings exist
if (_baseRadios isEqualTo []) then {
    // If not
    hint "There are no saved settings.";
} else {
    // Create a formatted string with the radio information and the Push To Talk assignment and Display as hint
    _hintString = format ["SAVED RADIO SETTINGS\n"];
    {
        _index = _forEachIndex;
        _baseRadio = (_baseRadios select _index) splitString "_" joinString " " select [4];
        _pttText = "";
        if (_index < 3) then {
            _pttText = format [" (PTT %1)", _index + 1];
        };
        _spatial = _spatials select _index;
        _spatialText = switch (_spatial) do {
            case "LEFT": {"Left Ear"};
            case "RIGHT": {"Right Ear"};
            case "CENTER": {"Both Ears"};
        };
        _volumeText = format ["%1", str round((_volumes select _index) * 100)];
        _hintString = _hintString + format ["\nRadio %1%2:\n%3\nChannel %4\nVolume: %5%6\n%7\n", _index + 1, _pttText, _baseRadio, _channels select _index, _volumeText, "%", _spatialText];
    } forEach _baseRadios;

    hint _hintString;
}