// THIS SCRIPT DOES NOT WORK YET

// Get the saved variables/arrays from the profileNamespace
_baseRadios = profileNamespace getVariable ["radios_base", []];
_channels = profileNamespace getVariable ["radios_channel", []];
_volumes = profileNamespace getVariable ["radios_volume", []];
_spatials = profileNamespace getVariable ["radios_spatial", []];
_pttAssignment = profileNamespace getVariable ["ptt_assignment", []];

// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Loop through the radios and set their settings
{
    // Check if we have looped through more than 6 radios
    if (_forEachIndex >= 6) exitWith {};

    // Set the base radio type for the radio ID
    [_x, _baseRadios select _forEachIndex] call acre_api_fnc_setBaseRadio;

    // Set the channel for the radio
    [_x, _channels select _forEachIndex] call acre_api_fnc_setRadioChannel;

    // Set the volume for the radio
    [_x, _volumes select _forEachIndex] call acre_api_fnc_setRadioVolume;

    // Set the spatial setting for the radio
    [_x, _spatials select _forEachIndex] call acre_api_fnc_setRadioSpatial;

} forEach _radios;

// Set the PTT assignment
{
    // Check if the PTT index is less than the count of _pttAssignment
    if (_forEachIndex < count _pttAssignment) then {
        // Set the PTT assignment
        [_forEachIndex, _x] call acre_api_fnc_setMultiPushToTalkAssignment;
    };
} forEach _pttAssignment;

// Display the hint in-game
hint "Radio Settings Loaded";
