page 51691 "LoanBalanc List-Approved"
{
    // version TL2.0

    Caption = 'Posted Loan Balancing';
    CardPageID = "Loan Balancing";
    PageType = List;
    SourceTable = "Loan Balancing";
    SourceTableView = WHERE(Posted = filter(true));
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
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
                field("Source Account No."; Rec."Source Account No.")
                {
                    ApplicationArea = All;
                }
                field("Source Account Name"; Rec."Source Account Name")
                {
                    ApplicationArea = All;
                }
                field("Source Account Balance"; Rec."Source Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Loan Account No."; Rec."Loan Account No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Description"; Rec."Loan Description")
                {
                    ApplicationArea = All;
                }
                field("Loan Account Balance"; Rec."Loan Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Loan Balancing Amount"; Rec."Loan Balancing Amount")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
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

