page 50709 "Procurement Sub Types"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Procurement Sub Types";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("Sub Type"; Rec."Sub Type")
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

