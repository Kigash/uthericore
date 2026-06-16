page 50332 "Loan Writeoff List-Posted"
{
    // version TL2.0

    Caption = 'Posted Loan Writeoff';
    CardPageID = "Loan Writeoff";
    PageType = List;
    SourceTable = "Loan Writeoff Header";
    SourceTableView = WHERE(Status = FILTER(Approved),
                            Posted = FILTER(true));
    UsageCategory = Administration;
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

