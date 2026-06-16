page 50983 "Boardroom Information List"
{
    // version TL2.0

    CardPageID = "Boardroom Information Card";
    PageType = List;
    SourceTable = "Boardroom Detail";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Boardroom No"; Rec."Boardroom No")
                {
                    ApplicationArea = All;

                }
                field("Boardroom Name"; Rec."Boardroom Name")
                {
                    ApplicationArea = All;

                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;

                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;

                }
                field(Register; Rec.Register)
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

