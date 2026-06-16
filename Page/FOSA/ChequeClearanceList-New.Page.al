page 50162 "Cheque Clearance List-New"
{
    // version TL2.0

    Caption = 'New Cheque Clearance';
    CardPageID = "Cheque Clearance";
    PageType = List;
    SourceTable = "Cheque Clearance Header";
    SourceTableView = WHERE(Status = FILTER(New));

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

            }
        }
    }

    actions
    {
    }
}

