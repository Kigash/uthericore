pageextension 50811 VendorPageEXT extends "Vendor Card"
{

    layout
    {
        addafter("Search Name")
        {
            field("Vendor Type"; Rec."Vendor Type")
            {
                ApplicationArea = All;
            }

            field("Pre-Qualified"; Rec."Pre-Qualified")
            {
                ApplicationArea = All;
            }
            field("Prequalified Category Desc"; Rec."Prequalified Category Desc")
            {
                ApplicationArea = All;
            }
            field("Prequalified Category Code"; Rec."Prequalified Category Code")
            {
                ApplicationArea = All;
            }


            field("Bank Account"; Rec."Bank Account")
            {
                ApplicationArea = All;
            }
            field("Payment Receipt"; Rec."Payment Receipt")
            {
                ApplicationArea = All;
            }
        }

    }

}
