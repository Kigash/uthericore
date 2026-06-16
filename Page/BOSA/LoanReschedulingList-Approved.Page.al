page 50263 "Loan Resched. List-Approved"
{
    // version TL2.0

    Caption = 'Approved Loan Reschedulings';
    CardPageID = "Loan Rescheduling";
    PageType = List;
    SourceTable = "Loan Rescheduling";
    SourceTableView = WHERE(Status = FILTER(Approved));
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
                field("Loan No."; Rec."Loan No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Approved Loan Amount"; Rec."Approved Loan Amount")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Loan Balance"; Rec."Outstanding Loan Balance")
                {
                    ApplicationArea = All;
                }
                field("Rescheduling Type"; Rec."Rescheduling Type")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Approved By"; Rec."Approved By")
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

