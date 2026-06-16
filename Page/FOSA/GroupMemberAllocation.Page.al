page 55034 "Group Member Allocation"
{
    // version MC2.0

    AutoSplitKey = true;
    Caption = 'Group Member Allocations';
    PageType = List;
    RefreshOnActivate = true;
    SourceTable = "Group Member Allocation";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Loan Account"; Rec."Loan Account")
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
                field("Amount Due"; Rec."Amount Due")
                {
                    ApplicationArea = All;
                }
                field("Amount in Arrears"; Rec."Amount in Arrears")
                {
                    ApplicationArea = All;
                }
                field("Overpayment Amount"; Rec."Overpayment Amount")
                {
                    ApplicationArea = All;
                }
                field("Allocation Amount"; Rec."Allocation Amount")
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

