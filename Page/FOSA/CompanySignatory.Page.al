page 50056 "Company Signatory"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Beneficiary Type";
    SourceTableView = WHERE(Type = CONST("Company Signatory"));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field(Position; Rec.Position)
                {
                    ApplicationArea = All;
                }
                field(Signature; Rec.Signature)
                {
                    ApplicationArea = All;
                }
                field("Front Side ID"; Rec."Front ID")
                {
                    ApplicationArea = All;
                }
                field("Back Side ID"; Rec."Back ID")
                {
                    ApplicationArea = All;
                }
                field(Picture; Rec.Picture)
                {
                    ApplicationArea = All;
                }
                field("Allocation (%)"; Rec."Allocation (%)")
                {
                    ApplicationArea = All;
                }
                field("Witness Name"; Rec."Witness Name")
                {
                    ApplicationArea = All;
                }
                field("Witness National ID"; Rec."Witness National ID")
                {
                    ApplicationArea = All;
                }
                field("Witness Mobile No."; Rec."Witness Mobile No.")
                {
                    ApplicationArea = All;
                }
                field("Witness Postal Address"; Rec."Witness Postal Address")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

