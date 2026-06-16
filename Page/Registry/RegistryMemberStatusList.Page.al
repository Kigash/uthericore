page 50954 "Registry Member Status"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Registry File Status";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Status Code"; Rec."Status Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
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

