page 50460 "Position Responsibilities"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = 50233;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Responsibility; Rec.Responsibility)
                {
                    ApplicationArea = All;
                }
                field(Remarks; Rec.Remarks)
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
