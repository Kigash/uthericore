page 50296 "Remittance Codes"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Remittance Code";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field("Account Category"; Rec."Account Category")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Contribution Type"; Rec."Contribution Type")
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

