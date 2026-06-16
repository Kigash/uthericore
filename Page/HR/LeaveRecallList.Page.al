page 50434 "Leave Recalls List"
{
    // version TL2.0

    CardPageID = "Leave Recall Card";
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50222;
    SourceTableView = WHERE(Status = FILTER('Open'));
    UsageCategory = Lists;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(general)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field("Employee No"; Rec."Employee No")
                {
                    ApplicationArea = All;
                }
                field("Employee Name"; Rec."Employee Name")
                {
                    ApplicationArea = All;
                }
                field("Leave Start Date"; Rec."Leave Start Date")
                {
                    ApplicationArea = All;
                }
                field("Days Applied"; Rec."Days Applied")
                {
                    ApplicationArea = All;
                }
                field("Leave Ending Date"; Rec."Leave Ending Date")
                {
                    ApplicationArea = All;
                }
                field("Recall Date"; Rec."Recall Date")
                {
                    ApplicationArea = All;
                }
                field("Recalled By"; Rec."Recalled By")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field("Recall Department"; Rec."Recall Department")
                {
                    ApplicationArea = All;
                }
                field("Recall Branch"; Rec."Recall Branch")
                {
                    ApplicationArea = All;
                }
                field("Reason for Recall"; Rec."Reason for Recall")
                {
                    ApplicationArea = All;
                }
                field("Recalled To"; Rec."Recalled To")
                {
                    ApplicationArea = All;
                }
                field("Recalled From"; Rec."Recalled From")
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
