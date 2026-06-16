page 50998 "Schedule List"
{
    // version TL2.0

    CardPageID = "Schedule Card";
    PageType = List;
    SourceTable = "CEO Schedule";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No of meetings"; Rec."No of meetings")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Meeting Type"; Rec."Meeting Type")
                {
                    ApplicationArea = All;
                }
                field("No of appointments"; Rec."No of appointments")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Appointments type"; Rec."Appointments type")
                {
                    ApplicationArea = All;
                }
                field("Appointments time"; Rec."Appointments time")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Schedule; Rec.Schedule)
                {
                    ApplicationArea = All;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(User; Rec.User)
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

