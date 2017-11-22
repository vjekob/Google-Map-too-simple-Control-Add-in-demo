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
        var addressStr = address.address +
            (address.zip && (", " + address.zip)) +
            (address.city && (", " + address.city)) +
            (address.region && (", " + address.region));

        geolocate(addressStr, function (pos) {
            ctrlGoogleMap.panTo(pos);
        });
    };

    return showAddress;
})();

function UpdateAddress(latitude, longitude) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode(
        { 'latLng': new google.maps.LatLng(latitude, longitude) },
        function (results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                var geo = {};
                results[0].address_components.forEach(function (comp) {
                    comp.types.forEach(function (name) {
                        geo[name] = comp.long_name;
                    });
                });

                if (confirm("Update customer address to:\n\n" +
                    results[0].formatted_address))
                    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("UpdateAddress", [{
                        address: (geo.street_number || '') + ' ' + (geo.route || ''),
                        zip: geo.postal_code,
                        city: geo.locality,
                        region: geo.country
                    }]);
            };
        });
};