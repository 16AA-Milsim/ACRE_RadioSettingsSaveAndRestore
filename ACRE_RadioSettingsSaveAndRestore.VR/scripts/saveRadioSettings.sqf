// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Loop through each radio in the list and extract its base type, channel, volume, spatial setting, and Push To Talk assignment
_baseRadios = [];
_channels = [];
_volumes = [];
_spatials = [];
_pttAssignments = [];
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

// Get the current PTT key for all the radios
_pttAssignment = call acre_api_fnc_getMultiPushToTalkAssignment;

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
