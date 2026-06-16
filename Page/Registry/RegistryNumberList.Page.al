page 50951 "Registry Number"
{
    // version TL2.0

    PageType = List;
    SourceTable = "Registry Number";
    CardPageId = 50950;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Branch; Rec.Branch)
                {
                    ApplicationArea = All;
                }
                field("RegFile Status"; Rec."RegFile Status")
                {
                    ApplicationArea = All;
                }
                field("No. Series"; Rec."No. Series")
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

