// THIS SCRIPT DOES NOT WORK YET

// Get the saved variables/arrays from the profileNamespace
_baseRadios = profileNamespace getVariable ["radios_base", []];
_channels = profileNamespace getVariable ["radios_channel", []];
_volumes = profileNamespace getVariable ["radios_volume", []];
_spatials = profileNamespace getVariable ["radios_spatial", []];
_pttAssignment = profileNamespace getVariable ["ptt_assignment", []];

// Get the current radio list
_radios = [] call acre_api_fnc_getCurrentRadioList;

// Check if the player is carrying any radios
if (count _radios == 0) then {
    hint "You are not carrying any radios";
} else {
    // Create copies of the saved arrays to work with
    _baseRadiosCopy = +_baseRadios;
    _channelsCopy = +_channels;
    _volumesCopy = +_volumes;
    _spatialsCopy = +_spatials;

    // Check if any radios have matching base types
    _foundMatchingRadios = false;

    // Loop through the radios and set their settings
    {
        // Check if we have looped through more than 6 radios
        if (_forEachIndex >= 6) exitWith {};

        // Extract the base radio type from the radio ID
        _currentBaseRadio = [_x] call acre_api_fnc_getBaseRadio;

        // Check if the current base radio type is in the saved baseRadios array
        _index = _baseRadiosCopy find _currentBaseRadio;
        if (_index != -1) then {

            // Set the channel for the radio
            [_x, _channelsCopy select _index] call acre_api_fnc_setRadioChannel;

            // Set the volume for the radio
            [_x, _volumesCopy select _index] call acre_api_fnc_setRadioVolume;

            // Set the spatial setting for the radio
            [_x, _spatialsCopy select _index] call acre_api_fnc_setRadioSpatial;

            // Remove the used base radio type and its associated settings from the copied arrays
            _baseRadiosCopy deleteAt _index;
            _channelsCopy deleteAt _index;
            _volumesCopy deleteAt _index;
            _spatialsCopy deleteAt _index;

            // Set flag to indicate matching radio was found
            _foundMatchingRadios = true;
        };
    } forEach _radios;

    if (_foundMatchingRadios) then {
        // Restore the PTT assignment
        _pttTemp = [];

        {
            // Get the base radio for the current PTT assignment
            _currentBaseRadio = [_x] call acre_api_fnc_getBaseRadio;

            // Check if the current base radio type is in the saved pttAssignment array
            _index = _pttAssignment find _currentBaseRadio;
            if (_index != -1) then {
                _pttTemp pushBack _x;
            };
        } forEach _pttAssignment;

        // Set the restored PTT assignment
        [_pttTemp] call acre_api_fnc_setMultiPushToTalkAssignment;

        // Check if all base radios were matched
        if (count _baseRadiosCopy == 0) then {
            hint "Radio Settings Restored";
        } else {
            hint "Not all radio settings could be restored due to missing radios in your inventory";
        };
    } else {
        // Display failure message
        hint "No matching radios found";
    };
};