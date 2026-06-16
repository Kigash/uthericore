page 50993 "Notice List"
{
    // version TL2.0

    CardPageID = "Notice Card";
    PageType = List;
    SourceTable = Notice;

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
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Agenda; Rec.Agenda)
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
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

