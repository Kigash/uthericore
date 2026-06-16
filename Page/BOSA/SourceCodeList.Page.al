page 50193 "Source Code List"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Source Code";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                /*                 field("Reason Code"; Rec."Reason Code")
                                {
                                } */
                field(Code; Rec.Code)
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

