page 50331 "Loan Writeoff List-Rejected"
{
    // version TL2.0

    Caption = 'Rejected Loan Writeoff';
    CardPageID = "Loan Writeoff";
    PageType = List;
    SourceTable = "Loan Writeoff Header";
    SourceTableView = WHERE(Status = FILTER(Rejected));
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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
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

