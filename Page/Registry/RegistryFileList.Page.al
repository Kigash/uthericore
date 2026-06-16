page 50958 "Registry File List"
{
    // version TL2.0

    CardPageID = "Inventory File Card";
    DelayedInsert = false;
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Registry File";
    SourceTableView = WHERE(Created = FILTER('Yes'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("RegFile Status"; Rec."RegFile Status")
                {
                    Caption = 'File Status';
                    ApplicationArea = All;
                }
                field("File No."; Rec."File No.")
                {
                    Visible = false;
                    ApplicationArea = All;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                }
                field("File Type"; Rec."File Type")
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                }
                field("ID No."; Rec."ID No.")
                {
                    ApplicationArea = All;
                }
                field("Payroll No."; Rec."Payroll No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                }
                field("Date Created"; Rec."Date Created")
                {
                    ApplicationArea = All;
                }
                field("File Request Status"; Rec."File Request Status")
                {
                    ApplicationArea = All;
                }
                field("Current User"; Rec."Current User")
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

