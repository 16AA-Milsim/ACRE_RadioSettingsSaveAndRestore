_baseRadios = [];
_channels = [];
_volumes = [];
_spatials = [];

// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Get the PTT keys for each radio
_pttAssignment = call acre_api_fnc_getMultiPushToTalkAssignment;

// Loop through the PTT assignments and rearrange the radios in the _radios array
_tempRadios = [];
{
    _pttRadio = _x;
    {
        if (_pttRadio == _x) then {
            _tempRadios pushBack _x;
        };
    } forEach _radios;
} forEach _pttAssignment;

// Add any remaining radios to the end of the _tempRadios array
{
    if (_tempRadios find _x == -1) then {
        _tempRadios pushBack _x;
    };
} forEach _radios;

// Set the _radios array to the rearranged array
_radios = _tempRadios;

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

// Display the hint in-game
hint "Radio Settings Saved";