page 50277 "Guarantor Allocation List"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Guarantor Allocation";
    AutoSplitKey = true;
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
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Other Guaranteed Amount"; Rec."Other Guaranteed Amount")
                {
                    ApplicationArea = All;
                }
                field("Net Account Balance"; Rec."Net Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Amount To Guarantee"; Rec."Amount To Guarantee")
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

