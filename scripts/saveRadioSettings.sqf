// Define Arrays
_baseRadios = [];
_channels = [];
_volumes = [];
_spatials = [];
_pttAssignments = [];
_pttAssignment1 = [];
_pttAssignment2 = [];
_pttAssignment3 = [];

// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Get the current PTT key and save the Base Radio Type for each PTT.
_pttAssignment = call acre_api_fnc_getMultiPushToTalkAssignment;

// Check if pttAssignment array has at least one element
if (count _pttAssignment > 0) then {
    // Get base radio for first element of pttAssignment array
    _pttAssignment1 = [_pttAssignment select 0] call acre_api_fnc_getBaseRadio;

    // Check if pttAssignment array has at least two elements
    if (count _pttAssignment > 1) then {
        // Get base radio for second element of pttAssignment array
        _pttAssignment2 = [_pttAssignment select 1] call acre_api_fnc_getBaseRadio;
    };

    // Check if pttAssignment array has at least three elements
    if (count _pttAssignment > 2) then {
        // Get base radio for third element of pttAssignment array
        _pttAssignment3 = [_pttAssignment select 2] call acre_api_fnc_getBaseRadio;
    };
};
_pttAssignment =  [_pttAssignment1, _pttAssignment2, _pttAssignment3];
_hintString = format ["%1", _pttAssignment];
hint _hintString;

// Loop through each radio in the list and extract its base type, channel, volume and spatial setting
{
    // Check if we have looped through more than 6 radios
    if (_forEachIndex >= 6) exitWith {};

    // Extract the base radio type from the radio ID
    _baseRadio = [_x] call acre_api_fnc_getBaseRadio;

    // Add the base radio type to the baseRadios array
    _baseRadios pushBack _baseRadio;

    // Get the current channel for the radio
    _channel = [_x] call acre_api_fnc_getRadioChannel;

    // Add the channel to the channels array
    _channels pushBack _channel;

    // Get the current volume for the radio
    _volume = [_x] call acre_api_fnc_getRadioVolume;

    // Add the volume to the volumes array
    _volumes pushBack _volume;

    // Get the current spatial setting for the radio
    _spatial = [_x] call acre_api_fnc_getRadioSpatial;

    // Add the spatial setting to the spatials array
    _spatials pushBack _spatial;
    
} forEach _radios;

// Add the variables/arrays to the profileNamespace
profileNamespace setVariable ["radios_base", _baseRadios];
profileNamespace setVariable ["radios_channel", _channels];
profileNamespace setVariable ["radios_volume", _volumes];
profileNamespace setVariable ["radios_spatial", _spatials];
profileNamespace setVariable ["ptt_assignment", _pttAssignment];

// Display the hint in-game
hint "Radio Settings Saved";
sleep 5;
hintsilent "";