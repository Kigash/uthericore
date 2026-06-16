page 50252 "Member Claim Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Member Claim Line";

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
                field("Account Ownership"; Rec."Account Ownership")
                {
                    ApplicationArea = All;
                }
                field("Account Balance"; Rec."Account Balance")
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

