page 50210 "Loan Guarantor List"
{
    // version TL2.0

    AutoSplitKey = true;
    PageType = List;
    SourceTable = "Loan Guarantor";
    UsageCategory = Lists;
    ApplicationArea = All;

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
                    Enabled = false;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Other Guaranteed Amount"; Rec."Other Guaranteed Amount")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Net Account Balance"; Rec."Net Account Balance")
                {
                    ApplicationArea = All;
                    Enabled = false;
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

