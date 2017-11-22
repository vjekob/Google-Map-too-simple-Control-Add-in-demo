page 50121 GoogleMapCardPart
{
    CaptionML = ENU='Map';
    PageType = CardPart;
    SourceTable = Customer;
    
    layout
    {
        area(Content)
        {
            usercontrol(GoogleMap;GoogleMapCtrl)
            {
                trigger ControlReady();
                begin
                    MapIsReady := true;
                    ShowAddress();
                end;
            }
        }
    }
    
    var
        MapIsReady: Boolean;
        
    local procedure ShowAddress();
    var
        CustAddress: Text;
    begin
        if not MapIsReady then
            exit;

        CustAddress := Rec.Address;
        if Rec."Post Code" <> '' then
            CustAddress += ', ' + Rec."Post Code";
        if Rec.City <> '' then
            CustAddress += ', ' + Rec.City;
        if Rec."Country/Region Code" <> '' then
            CustAddress += ', ' + Rec."Country/Region Code";

        CurrPage.GoogleMap.ShowAddress(CustAddress);
    end;
    
    trigger OnAfterGetRecord();
    begin
        ShowAddress();
    end;
}