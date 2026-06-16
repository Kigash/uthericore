page 51601 "Loan Restruct List-Approved"
{
    // version TL2.0

    Caption = 'Approved Loan Restructuring';
    CardPageID = "Loan Restructuring";
    PageType = List;
    SourceTable = "Loan Restructuring";
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
                field("Restructuring Type"; Rec."Restructuring Type")
                {
                    Visible = false;
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

