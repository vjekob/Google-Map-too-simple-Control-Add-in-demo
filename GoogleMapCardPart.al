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
                
                trigger UpdateAddress(address : JsonObject);
                begin
                    Rec.Address := GetJsonTokenValue(address, 'address');
                    Rec."Post Code" := GetJsonTokenValue(address, 'zip');
                    Rec.City := GetJsonTokenValue(address, 'city');
                    Rec."Country/Region Code" := GetRegionCode(GetJsonTokenValue(address, 'region'));
                    Rec.Modify();
                    CurrPage.Update(false);
                end;
            }
        }
    }
    
    var
        MapIsReady: Boolean;
        
    local procedure ShowAddress();
    var
        CustAddress: JsonObject;
    begin
        if not MapIsReady then
            exit;
            
        CustAddress.Add('address',Rec.Address);
        if Rec."Post Code" <> '' then
            CustAddress.Add('zip',Rec."Post Code");
        if Rec.City <> '' then
            CustAddress.Add('city',Rec.City);
        if Rec."Country/Region Code" <> '' then
            CustAddress.Add('region',Rec."Country/Region Code");
            
        CurrPage.GoogleMap.ShowAddress(CustAddress);
    end;
    
    local procedure GetJsonTokenValue(Json: JsonObject; Property: Text): Text;
    var
        Token: JsonToken;
    begin
        if Json.Get(Property,Token) then
            exit(Token.AsValue().AsText());
    end;

    local procedure GetRegionCode(Region: Text): Code[10];
    var
        CountryRegion: Record "Country/Region";
    begin
        CountryRegion.SetFilter(Name, Region);
        if CountryRegion.FindFirst() then
            exit(CountryRegion.Code);
    end;
    
    trigger OnAfterGetRecord();
    begin
        ShowAddress();
    end;
}