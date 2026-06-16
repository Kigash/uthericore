page 50752 "Pre-Qualified Supplier Card"
{
    // version TL2.0

    PageType = Card;
    SourceTable = "Prequalified Suppliers";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Category Code"; Rec."Category Code")
                {
                    ApplicationArea = All;
                }
                field("Category Description"; Rec."Category Description")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                }
                field("Company PIN No."; Rec."Company PIN No.")
                {
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                Caption = 'Communication';
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                }
                field("Home Page"; Rec."Home Page")
                {
                    ApplicationArea = All;
                }
            }
            group("Other Details")
            {
                field("AGPO Cert"; Rec."AGPO Cert")
                {
                    ApplicationArea = All;
                }
                field("AGPO Category"; Rec."AGPO Category")
                {
                    ApplicationArea = All;
                }
                field("Bank Account"; Rec."Bank Account")
                {
                    ApplicationArea = All;
                }
                /*  field("KBA Code"; Rec."KBA Code")
                 {
                     ApplicationArea = All;
                 }
                 field("Bank Code"; Rec."Bank Code")
                 {
                     ApplicationArea = All;
                 } */
            }
        }
    }

    actions
    {
    }
}
