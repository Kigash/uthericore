page 50439 "Submitted Leave Recalls"
{
    CardPageID = "Leave Recall Card";
    Editable = false;
    DeleteAllowed = false;
    PageType = List;
    SourceTable = 50222;
    SourceTableView = WHERE(Status = FILTER('Released'));
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

    trigger OnOpenPage();
    begin
        CurrPage.EDITABLE(FALSE);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Error(Error000);
    end;

    trigger OnModifyRecord(): Boolean;
    begin
        Error(Error001);
    end;

    var
        Error000: Label 'You cannot create a new record!';
        Error001: Label 'You cannot modify this record!';
}
