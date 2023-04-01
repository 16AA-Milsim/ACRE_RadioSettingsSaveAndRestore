_baseRadios = profileNamespace getVariable "radios_base";
_channels = profileNamespace getVariable "radios_channel";
_volumes = profileNamespace getVariable "radios_volume";
_spatials = profileNamespace getVariable "radios_spatial";
_pttAssignment = profileNamespace getVariable "ptt_assignment";

// Create a formatted string with the radio information and the Push To Talk assignment and Display as hint
_hintString = "RADIO INFORMATION:\n\n";
{
    _index = _forEachIndex;
    _hintString = _hintString + format ["Radio %1 - Base type: %2\nChannel: %3\nVolume: %4\nSpatial: %5\n\n", _index, _baseRadios select _index, _channels select _index, _volumes select _index, _spatials select _index];
} forEach _baseRadios;
_hintString = _hintString + format ["PTT Assignment: %1", _pttAssignment];

// Display the hint in-game for 10 seconds
hint "Not Implemented Yet";
sleep 5;
hintSilent "";
