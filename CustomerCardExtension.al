pageextension 50121 CustomerCardExtension extends "Customer Card"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(Map;GoogleMapCardPart)
            {
                SubPageLink = "No." = field("No.");
            }
        }
    }
}