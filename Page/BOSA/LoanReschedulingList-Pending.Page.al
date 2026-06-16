page 50262 "Loan Rescheduling List-Pending"
{
    // version TL2.0

    Caption = 'Pending Loan Reschedulings';
    CardPageID = "Loan Rescheduling";
    PageType = List;
    SourceTable = "Loan Rescheduling";
    SourceTableView = WHERE(Status = FILTER("Pending Approval"));
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
            }
        }
    }

    actions
    {
    }
}

