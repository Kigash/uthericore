page 50293 "Member Remittance Subform"
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Member Remittance Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
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

