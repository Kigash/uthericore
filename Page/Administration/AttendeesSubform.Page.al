page 50987 "Attendees Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = Attendance;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Attendee Names"; Rec."Attendee Names")
                {
                    ApplicationArea = All;

                }
                field("Meeting Agenda"; Rec."Meeting Agenda")
                {
                    ApplicationArea = All;
                    Visible = false;

                }
                field("Email Address"; Rec.Remarks)
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

