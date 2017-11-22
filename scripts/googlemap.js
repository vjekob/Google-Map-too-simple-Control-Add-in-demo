var ShowAddress = (function () {
    function geolocate(address, callback) {
        var geocoder = new google.maps.Geocoder(),
            location = null;

        geocoder.geocode(
            { "address": address },
            function (results, status) {
                if (status === google.maps.GeocoderStatus.OK)
                    callback(new google.maps.LatLng(
                        latitude = results[0].geometry.location.lat(),
                        longitude = results[0].geometry.location.lng()));
            });
    };

    function showAddress(address) {
        geolocate(address, function (pos) {
            ctrlGoogleMap.panTo(pos);
        });
    };

    return showAddress;
})();
