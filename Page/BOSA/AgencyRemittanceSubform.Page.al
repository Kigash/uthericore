page 50339 "Agency Remittance Subform"
{
    // version TL2.0

    Editable = false;
    PageType = ListPart;
    SourceTable = "Agency Remittance Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
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
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Remittance Code"; Rec."Remittance Code")
                {
                    ApplicationArea = All;
                }
                field("Contribution Type"; Rec."Contribution Type")
                {
                    ApplicationArea = All;
                }
                field("Expected Amount"; Rec."Expected Amount")
                {
                    ApplicationArea = All;
                }
                field("Actual Amount"; Rec."Actual Amount")
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

