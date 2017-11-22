window.ctrlGoogleMap = new google.maps.Map(document.getElementById("controlAddIn"),
    {
        center: new google.maps.LatLng(55.77044, 12.50378),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    
google.maps.event.addListener(ctrlGoogleMap, "click", function (event) {
    UpdateAddress(event.latLng.lat(), event.latLng.lng());
});

Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
