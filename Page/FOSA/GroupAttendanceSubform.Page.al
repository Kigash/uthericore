page 55028 "Group Attendance Subform"
{
    // version MC2.0

    Caption = 'Group Attendance Subform';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = ListPart;
    SourceTable = "Group Attendance Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    Editable = false;
                    ApplicationArea = All;
                }
                field(Present; Rec.Present)
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

