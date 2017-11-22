window.ctrlGoogleMap = new google.maps.Map(document.getElementById("controlAddIn"),
    {
        center: new google.maps.LatLng(55.77044, 12.50378),
        zoom: 8,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    });
    
Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('ControlReady', []);
